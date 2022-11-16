import * as THREE from "three";

/**
 * Animation: The animation
 * @param scene the scene into which to render
 * @param camera the camera for the animation
 * @param renderer the renderer
 */
 function animation(scene, camera, renderer){
    const light = new THREE.AmbientLight(0xf0f0f0); // soft white light
    const axes = new THREE.AxesHelper(5);
        
    // create common geometry and materials
    const sc_geometry = new THREE.BoxGeometry(1, 1, 1);
    const sc_wire_geometry = new THREE.EdgesGeometry(sc_geometry);
    const line_material = new THREE.LineBasicMaterial({color: 0xffffff, linewidth: 10});
    const p = new THREE.Vector3(1, 0, 0);

    // current spacecraft
    const current_material = new THREE.MeshStandardMaterial({color: 0xaaaaaa})
    const current = new THREE.Mesh(sc_geometry, current_material);
    const current_wireframe = new THREE.LineSegments(sc_wire_geometry, line_material);
    const current_p = new THREE.ArrowHelper(
        p.normalize(), new THREE.Vector3(0, 0, 0), 1, 0xff0000);

    // target spacecraft
    const target_material = new THREE.MeshStandardMaterial({color: 0xaaaaaa, transparent: true, opacity: 0.4})
    const target = new THREE.Mesh(sc_geometry, target_material);
    const target_wireframe = new THREE.LineSegments(sc_wire_geometry, line_material);    
    const target_p = new THREE.ArrowHelper(
        p.normalize(), new THREE.Vector3(0, 0, 0), 1, 0x00ff00);

    // add to scene
    scene.add(light);
    scene.add(axes);
    scene.add(current);
    scene.add(current_wireframe);
    scene.add(current_p);
    scene.add(target);
    scene.add(target_wireframe);
    scene.add(target_p);
    
    /**
     * Rotate Current: Rotates all the current state objects to a given orientation
     * @param q the quaternion representing the orientation to rotate to
     */
    function rotateCurrent(q){
        current.setRotationFromQuaternion(q);
        current_wireframe.setRotationFromQuaternion(q);
        current_p.setRotationFromQuaternion(q);
    };

    /**
     * Rotate Target: Rotates all the target state objects to a given orientation
     * @param q the quaternion representing the orientation to rotate to
     */
     function rotateTarget(q){
        target.setRotationFromQuaternion(q);
        target_wireframe.setRotationFromQuaternion(q);
        target_p.setRotationFromQuaternion(q);
    };

    var t = 0;
    /**
     * animator
     */
    function animate(){
        requestAnimationFrame(animate);
        //const vec = new THREE.Vector3(1, 0, 0);
        //rotateCurrent(new THREE.Quaternion().setFromAxisAngle(vec, t/100));
        //rotateTarget(new THREE.Quaternion().setFromAxisAngle(vec, t/1000));
        render();
        t++;
    };

    function render() {
        renderer.render(scene, camera);
    }

    animate();    
}

export { animation }