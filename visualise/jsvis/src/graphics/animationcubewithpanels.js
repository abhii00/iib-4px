import * as THREE from "three";
import Papa from "papaparse";

import qcsv from '../main1.csv'
import tcsv from '../aux1.csv'

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
    
    // common geometry and materials
    const line_material = new THREE.LineBasicMaterial({color: 0xffffff});

    // actual spacecraft
    const actual_sc_geometry = new THREE.BoxGeometry(b, b, b);
    const actual_sc_wire_geometry = new THREE.EdgesGeometry(actual_sc_geometry);
    const actual_sc_material = new THREE.MeshStandardMaterial({color: 0xaaaaaa});
    const actual_sc = new THREE.Mesh(actual_sc_geometry, actual_sc_material);
    const actual_sc_wireframe = new THREE.LineSegments(actual_sc_wire_geometry, line_material);
    actual_sc_wireframe.scale.set(1.001, 1.001, 1.001);  
    const actual_p = new THREE.ArrowHelper(p, new THREE.Vector3(0, 0, 0), sf*b, 0xff0000); 

    // actual solar panels common geometry and materials
    const actual_sp_geometry = new THREE.BoxGeometry(b, b, b/30);
    const actual_sp_wire_geometry = new THREE.EdgesGeometry(actual_sp_geometry);
    const actual_sp_material = new THREE.MeshStandardMaterial({color: 0x000055});
    const actual_sp_line_material = new THREE.LineBasicMaterial({color: 0xbbbb00});

    // actual_sp1a
    const actual_sp1a = new THREE.Mesh(actual_sp_geometry, actual_sp_material);
    const actual_sp1a_wireframe = new THREE.LineSegments(actual_sp_wire_geometry, actual_sp_line_material); 
    actual_sp1a.position.set(0, b, 0); 
    actual_sp1a_wireframe.position.set(0, b, 0); 

    // actual_sp1b
    const actual_sp1b = new THREE.Mesh(actual_sp_geometry, actual_sp_material);
    const actual_sp1b_wireframe = new THREE.LineSegments(actual_sp_wire_geometry, actual_sp_line_material);  
    actual_sp1b.position.set(0, 2*b, 0); 
    actual_sp1b_wireframe.position.set(0, 2*b, 0); 

    // actual_sp2a
    const actual_sp2a = new THREE.Mesh(actual_sp_geometry, actual_sp_material);
    const actual_sp2a_wireframe = new THREE.LineSegments(actual_sp_wire_geometry, actual_sp_line_material);  
    actual_sp2a.position.set(0, -b, 0); 
    actual_sp2a_wireframe.position.set(0, -b, 0); 

    // actual_sp2b
    const actual_sp2b = new THREE.Mesh(actual_sp_geometry, actual_sp_material);
    const actual_sp2b_wireframe = new THREE.LineSegments(actual_sp_wire_geometry, actual_sp_line_material); 
    actual_sp2b.position.set(0, -2*b, 0); 
    actual_sp2b_wireframe.position.set(0, -2*b, 0);  

    // target spacecraft
    const target_sc_geometry = new THREE.BoxGeometry(b, b, b);
    const target_sc_wire_geometry = new THREE.EdgesGeometry(target_sc_geometry);
    const target_sc_material = new THREE.MeshStandardMaterial({color: 0xaaaaaa, transparent: true, opacity: 0.3});
    const target_sc = new THREE.Mesh(target_sc_geometry, target_sc_material);
    target_sc.renderOrder = 1;
    const target_sc_wireframe = new THREE.LineSegments(target_sc_wire_geometry, line_material);
    target_sc_wireframe.scale.set(1.001, 1.001, 1.001);  
    const target_p = new THREE.ArrowHelper(p, new THREE.Vector3(0, 0, 0), sf*b, 0x00ff00); 
    target_sc.scale.set(sf, sf, sf);
    target_sc_wireframe.scale.set(sf, sf, sf);

    // target solar panels common geometry and materials
    const target_sp_geometry = new THREE.BoxGeometry(b, b, b/30);
    const target_sp_wire_geometry = new THREE.EdgesGeometry(target_sp_geometry);
    const target_sp_material = new THREE.MeshStandardMaterial({color: 0xaaaaaa, transparent: true, opacity: 0.3});
    const target_sp_line_material = new THREE.LineBasicMaterial({color: 0xbbbb00});

    // target_sp1a
    const target_sp1a = new THREE.Mesh(target_sp_geometry, target_sp_material);
    const target_sp1a_wireframe = new THREE.LineSegments(target_sp_wire_geometry, target_sp_line_material); 
    target_sp1a.position.set(0, sf*b, 0); 
    target_sp1a_wireframe.position.set(0, sf*b, 0); 
    target_sp1a_wireframe.scale.set(1.001, 1.001, 1.001);
    target_sp1a.scale.set(sf, sf, sf);
    target_sp1a_wireframe.scale.set(sf, sf, sf);

    // target_sp1b
    const target_sp1b = new THREE.Mesh(target_sp_geometry, target_sp_material);
    const target_sp1b_wireframe = new THREE.LineSegments(target_sp_wire_geometry, target_sp_line_material);  
    target_sp1b.position.set(0, 2*sf*b, 0); 
    target_sp1b_wireframe.position.set(0, 2*sf*b, 0); 
    target_sp1b_wireframe.scale.set(1.001, 1.001, 1.001);
    target_sp1b.scale.set(sf, sf, sf);
    target_sp1b_wireframe.scale.set(sf, sf, sf);

    // target_sp2a
    const target_sp2a = new THREE.Mesh(target_sp_geometry, target_sp_material);
    const target_sp2a_wireframe = new THREE.LineSegments(target_sp_wire_geometry, target_sp_line_material);  
    target_sp2a.position.set(0, -sf*b, 0); 
    target_sp2a_wireframe.position.set(0, -sf*b, 0); 
    target_sp2a_wireframe.scale.set(1.001, 1.001, 1.001);
    target_sp2a.scale.set(sf, sf, sf);
    target_sp2a_wireframe.scale.set(sf, sf, sf);

    // target_sp2b
    const target_sp2b = new THREE.Mesh(target_sp_geometry, target_sp_material);
    const target_sp2b_wireframe = new THREE.LineSegments(target_sp_wire_geometry, target_sp_line_material); 
    target_sp2b.position.set(0, -2*sf*b, 0); 
    target_sp2b_wireframe.position.set(0, -2*sf*b, 0);  
    target_sp2b_wireframe.scale.set(1.001, 1.001, 1.001);
    target_sp2b.scale.set(sf, sf, sf);
    target_sp2b_wireframe.scale.set(sf, sf, sf);

    // add to scene
    scene.add(light);
    scene.add(axes_x);
    scene.add(axes_y);
    scene.add(axes_z);
    scene.add(actual_sc);
    scene.add(actual_sc_wireframe);
    scene.add(actual_p);
    scene.add(actual_sp1a);
    scene.add(actual_sp1b);
    scene.add(actual_sp2a);
    scene.add(actual_sp2b);
    scene.add(actual_sp1a_wireframe);
    scene.add(actual_sp1b_wireframe);
    scene.add(actual_sp2a_wireframe);
    scene.add(actual_sp2b_wireframe);
    scene.add(target_sc);
    scene.add(target_sc_wireframe);
    scene.add(target_p);
    scene.add(target_sp1a);
    scene.add(target_sp1b);
    scene.add(target_sp2a);
    scene.add(target_sp2b);
    scene.add(target_sp1a_wireframe);
    scene.add(target_sp1b_wireframe);
    scene.add(target_sp2a_wireframe);
    scene.add(target_sp2b_wireframe);

    // read quaternion information
    const ts = [];
    const qs_acc = [];
    const qs_tar = [];
    var maindataLoad = false;
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
            maindataLoad = true;
        },
    });

    const thetas_sp1a = [];
    const thetas_sp1b = [];
    const thetas_sp2a = [];
    const thetas_sp2b = [];
    var auxdataLoad = false;
    Papa.parse(tcsv, {
        header: false,
        download: true,
        skipEmptyLines: true,
        complete: res => {
            for (let i = 0; i < res.data.length; i++) {
                const l = res.data[i];
                thetas_sp1a.push(parseFloat(l[1]));
                thetas_sp1b.push(parseFloat(l[2]));
                thetas_sp2a.push(parseFloat(l[3]));
                thetas_sp2b.push(parseFloat(l[4]));
            }
            auxdataLoad = true;
        },
    });

    /**
     * Rotate Actual: Rotates all the actual state objects to a given orientation
     * @param q the quaternion representing the orientation to rotate to
     */
    function rotateActual(q){
        actual_sc.setRotationFromQuaternion(q);
        actual_sc_wireframe.setRotationFromQuaternion(q);
        actual_sp1a.setRotationFromQuaternion(q);
        actual_sp1b.setRotationFromQuaternion(q);
        actual_sp2a.setRotationFromQuaternion(q);
        actual_sp2b.setRotationFromQuaternion(q);
        actual_sp1a.position.copy(new THREE.Vector3(0, b, 0).applyQuaternion(q));
        actual_sp1b.position.copy(new THREE.Vector3(0, 2*b, 0).applyQuaternion(q));
        actual_sp2a.position.copy(new THREE.Vector3(0, -b, 0).applyQuaternion(q));
        actual_sp2b.position.copy(new THREE.Vector3(0, -2*b, 0).applyQuaternion(q));
        actual_sp1a_wireframe.setRotationFromQuaternion(q);
        actual_sp1b_wireframe.setRotationFromQuaternion(q);
        actual_sp2a_wireframe.setRotationFromQuaternion(q);
        actual_sp2b_wireframe.setRotationFromQuaternion(q);
        actual_sp1a_wireframe.position.copy(new THREE.Vector3(0, b, 0).applyQuaternion(q));
        actual_sp1b_wireframe.position.copy(new THREE.Vector3(0, 2*b, 0).applyQuaternion(q));
        actual_sp2a_wireframe.position.copy(new THREE.Vector3(0, -b, 0).applyQuaternion(q));
        actual_sp2b_wireframe.position.copy(new THREE.Vector3(0, -2*b, 0).applyQuaternion(q));
        actual_p.setDirection(p);
        actual_p.applyQuaternion(q);
    };

    /**
     * Rotate Target: Rotates all the target state objects to a given orientation
     * @param q the quaternion representing the orientation to rotate to
     */
    function rotateTarget(q){
        target_sc.setRotationFromQuaternion(q);
        target_sc_wireframe.setRotationFromQuaternion(q);
        target_sp1a.setRotationFromQuaternion(q);
        target_sp1b.setRotationFromQuaternion(q);
        target_sp2a.setRotationFromQuaternion(q);
        target_sp2b.setRotationFromQuaternion(q);
        target_sp1a.position.copy(new THREE.Vector3(0, sf*b, 0).applyQuaternion(q));
        target_sp1b.position.copy(new THREE.Vector3(0, 2*sf*b, 0).applyQuaternion(q));
        target_sp2a.position.copy(new THREE.Vector3(0, -sf*b, 0).applyQuaternion(q));
        target_sp2b.position.copy(new THREE.Vector3(0, -2*sf*b, 0).applyQuaternion(q));
        target_sp1a_wireframe.setRotationFromQuaternion(q);
        target_sp1b_wireframe.setRotationFromQuaternion(q);
        target_sp2a_wireframe.setRotationFromQuaternion(q);
        target_sp2b_wireframe.setRotationFromQuaternion(q);
        target_sp1a_wireframe.position.copy(new THREE.Vector3(0, sf*b, 0).applyQuaternion(q));
        target_sp1b_wireframe.position.copy(new THREE.Vector3(0, 2*sf*b, 0).applyQuaternion(q));
        target_sp2a_wireframe.position.copy(new THREE.Vector3(0, -sf*b, 0).applyQuaternion(q));
        target_sp2b_wireframe.position.copy(new THREE.Vector3(0, -2*sf*b, 0).applyQuaternion(q));
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
        if (maindataLoad && auxdataLoad){
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