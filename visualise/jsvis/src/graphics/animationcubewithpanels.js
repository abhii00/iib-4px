import * as THREE from "three";
import Papa from "papaparse";

import qcsv from '../sim.csv'

/**
 * AnimationCubeWithPanels: The animation for the simple cube with panels
 * @param scene the scene into which to render
 * @param camera the camera for the animation
 * @param renderer the renderer
 */
 function animationcubewithpanels(scene, camera, renderer){
    // parameters
    const p = new THREE.Vector3(1, 0, 0); // pointing
    const speed = 256; // speed
    const b = 3; // body size
    const sf = 1.2; // scale factor

    // origin, lighting and axes
    const o = new THREE.Vector3(0, 0, 0); // origin
    const x = new THREE.Vector3(1, 0, 0);
    const y = new THREE.Vector3(0, 1, 0);
    const z = new THREE.Vector3(0, 0, 1);
    const axes_x = new THREE.ArrowHelper(x, o, 4*sf*b, 0xffff00);
    const axes_y = new THREE.ArrowHelper(y, o, 4*sf*b, 0xff00ff);
    const axes_z = new THREE.ArrowHelper(z, o, 4*sf*b, 0x00ffff);
    const light = new THREE.AmbientLight(0xf0f0f0);
    
    // create common geometry and materials
    const sc_geometry = new THREE.BoxGeometry(b, b, b);
    const sc_wire_geometry = new THREE.EdgesGeometry(sc_geometry);
    const sp_geometry = new THREE.BoxGeometry(b, b, b/6);
    //const sp_wire_geometry = new THREE.EdgesGeometry(sp_geometry);
    const line_material = new THREE.LineBasicMaterial({color: 0xffffff});

    // actual spacecraft
    const actual_material = new THREE.MeshStandardMaterial({color: 0xaaaaaa});
    const actual = new THREE.Mesh(sc_geometry, actual_material);
    const actual_wireframe = new THREE.LineSegments(sc_wire_geometry, line_material); 
    const actual_p = new THREE.ArrowHelper(p, new THREE.Vector3(0, 0, 0), sf*b, 0xff0000); 
    
    // actual solar panels
    //const actual_sp1a = new THREE.Mesh(sp_geometry, actual_material);
    //const actual_sp1b = new THREE.Mesh(sp_geometry, actual_material);
    //const actual_sp2a = new THREE.Mesh(sp_geometry, actual_material);
    //const actual_sp2b = new THREE.Mesh(sp_geometry, actual_material);
    
    // target spacecraft
    const target_material = new THREE.MeshStandardMaterial({color: 0xaaaaaa, transparent: true, opacity: 0.3});
    const target = new THREE.Mesh(sc_geometry, target_material);
    const target_wireframe = new THREE.LineSegments(sc_wire_geometry, line_material);    
    target.scale.set(sf, sf, sf);
    target_wireframe.scale.set(sf, sf, sf);
    const target_p = new THREE.ArrowHelper(p, new THREE.Vector3(0, 0, 0), sf*b, 0x00ff00);

    // target solar panels
    const target_sp1a = new THREE.Mesh(sp_geometry, target_material);
    const target_sp1b = new THREE.Mesh(sp_geometry, target_material);
    const target_sp2a = new THREE.Mesh(sp_geometry, target_material);
    const target_sp2b = new THREE.Mesh(sp_geometry, target_material);
    target_sp1a.scale.set(sf, sf, sf);
    target_sp1b.scale.set(sf, sf, sf);
    target_sp2a.scale.set(sf, sf, sf);
    target_sp2b.scale.set(sf, sf, sf);

    // add to scene
    scene.add(light);
    scene.add(axes_x);
    scene.add(axes_y);
    scene.add(axes_z);
    scene.add(actual);
    scene.add(actual_wireframe);
    scene.add(actual_p);
    scene.add(target);
    scene.add(target_wireframe);
    scene.add(target_p);
    
    // read quaternion information
    const ts = [];
    const qs_acc = [];
    const qs_tar = [];
    var dataLoad = false;
    Papa.parse(qcsv, {
        header: false,
        download: true,
        skipEmptyLines: true,
        complete: res => {
            for (let i = 0; i < res.data.length; i++) {
                const l = res.data[i];
                ts.push(parseFloat(l[0]));
                qs_acc.push(new THREE.Quaternion(parseFloat(l[2]), parseFloat(l[3]), parseFloat(l[4]), parseFloat(l[1])));
                qs_tar.push(new THREE.Quaternion(parseFloat(l[14]), parseFloat(l[15]), parseFloat(l[16]), parseFloat(l[13])));
            }
            dataLoad = true;
        },
    });    ;

    /**
     * Rotate Actual: Rotates all the actual state objects to a given orientation
     * @param q the quaternion representing the orientation to rotate to
     */
    function rotateActual(q){
        actual.setRotationFromQuaternion(q);
        actual_wireframe.setRotationFromQuaternion(q);
        actual_p.setDirection(p);
        actual_p.applyQuaternion(q);
    };

    /**
     * Rotate Target: Rotates all the target state objects to a given orientation
     * @param q the quaternion representing the orientation to rotate to
     */
     function rotateTarget(q){
        target.setRotationFromQuaternion(q);
        target_wireframe.setRotationFromQuaternion(q);
        target_p.setDirection(p);
        target_p.applyQuaternion(q);
    };

    const clock = new THREE.Clock();
    var i = 0;
    /**
     * animator
     */
    function animate(){
        requestAnimationFrame(animate);
        if (dataLoad){
            var t = clock.getElapsedTime();
            if (t > ts[i]/speed && t < ts[ts.length - 1]/speed){
                // update quaternions from list
                rotateActual(qs_acc[i+1]);
                rotateTarget(qs_tar[i+1]);
                i++
            }
        }
        render();
    };

    function render() {
        renderer.render(scene, camera);
    }

    animate();    
}

export default animationcubewithpanels