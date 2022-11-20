import * as THREE from "three";
import Papa from "papaparse";

import qcsv from '../sim.csv'

/**
 * Animation: The animation
 * @param scene the scene into which to render
 * @param camera the camera for the animation
 * @param renderer the renderer
 */
 function animation(scene, camera, renderer){
    const light = new THREE.AmbientLight(0xf0f0f0); // soft white light
    const axes = new THREE.AxesHelper(5,);
    axes.setColors(0xffff00, 0xff00ff, 0x00ffff);
    const sf = 1.2;
        
    // create common geometry and materials
    const sc_geometry = new THREE.BoxGeometry(1, 1, 1);
    const sc_wire_geometry = new THREE.EdgesGeometry(sc_geometry);
    const line_material = new THREE.LineBasicMaterial({color: 0xffffff});
    const p = new THREE.Vector3(1, 0, 0);

    // current spacecraft
    const current_material = new THREE.MeshStandardMaterial({color: 0xaaaaaa});
    const current = new THREE.Mesh(sc_geometry, current_material);
    const current_wireframe = new THREE.LineSegments(sc_wire_geometry, line_material); 
    const current_p = new THREE.ArrowHelper(p.normalize(), new THREE.Vector3(0, 0, 0), sf, 0xff0000);
    
    // target spacecraft
    const target_material = new THREE.MeshStandardMaterial({color: 0xaaaaaa, transparent: true, opacity: 0.3});
    const target = new THREE.Mesh(sc_geometry, target_material);
    const target_wireframe = new THREE.LineSegments(sc_wire_geometry, line_material);    
    target.scale.set(sf, sf, sf);
    target_wireframe.scale.set(sf, sf, sf);
    const target_p = new THREE.ArrowHelper(p.normalize(), new THREE.Vector3(0, 0, 0), sf, 0x00ff00);

    // add to scene
    scene.add(light);
    scene.add(axes);
    scene.add(current);
    scene.add(current_wireframe);
    scene.add(current_p);
    scene.add(target);
    scene.add(target_wireframe);
    scene.add(target_p);
    
    // read quaternion information
    var r = [];
    const tout = [];
    const Qs_sta = [];
    const Qs_tar = [];
    var dataLoad = false;
    Papa.parse(qcsv, {
        header: false,
        download: true,
        skipEmptyLines: true,
        complete: res => {
            r = res.data;
            for (let i = 0; i < r.length; i++) {
                const l = r[i];
                tout.push(parseFloat(l[0]));
                Qs_sta.push(new THREE.Quaternion(parseFloat(l[2]), parseFloat(l[3]), parseFloat(l[4]), parseFloat(l[1])));
                Qs_tar.push(new THREE.Quaternion(parseFloat(l[6]), parseFloat(l[7]), parseFloat(l[8]), parseFloat(l[5])));
            }
            dataLoad = true;
        },
    });    

    /**
     * Rotate Current: Rotates all the current state objects to a given orientation
     * @param q the quaternion representing the orientation to rotate to
     */
    function rotateCurrent(q){
        current.setRotationFromQuaternion(q);
        current_wireframe.setRotationFromQuaternion(q);
        current_p.applyQuaternion(q);
    };

    /**
     * Rotate Target: Rotates all the target state objects to a given orientation
     * @param q the quaternion representing the orientation to rotate to
     */
     function rotateTarget(q){
        target.setRotationFromQuaternion(q);
        target_wireframe.setRotationFromQuaternion(q);
        target_p.applyQuaternion(q);
    };

    const speed = 256;
    const clock = new THREE.Clock();
    var i = 0;
    var q_sta = current.quaternion;
    var q_tar = target.quaternion;
    /**
     * animator
     */
    function animate(){
        requestAnimationFrame(animate);
        if (dataLoad){
            var t = clock.getElapsedTime();
            if (t > tout[i]/speed && t < tout[tout.length - 1]/speed){
                // update quaternions from list
                q_sta = Qs_sta[i+1];
                q_tar = Qs_tar[i+1];
                i++
            }
            current_p.setDirection(p.normalize());
            target_p.setDirection(p.normalize());
            rotateCurrent(q_sta);
            rotateTarget(q_tar);
        }
        render();
    };

    function render() {
        renderer.render(scene, camera);
    }

    animate();    
}

export { animation }