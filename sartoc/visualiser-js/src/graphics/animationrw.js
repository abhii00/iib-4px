import * as THREE from "three";
import { Vector3 } from "three";

/**
 * AnimationRW: The animation to display the reaction wheels
 * @param scene the scene into which to render
 * @param camera the camera for the animation
 * @param renderer the renderer
 */
 function animationrw(scene, camera, renderer){
    // parameters
    const p = new Vector3(1, 0, 0);
    const b = 3; // body size
    const sf = 1.2; // scale factor
    const beta = Math.PI * 45/180;
    const rw_offset = b/6; // location of rw

    // origin, lighting and axes
    const o = new THREE.Vector3(0, 0, 0); // origin
    const x = new THREE.Vector3(1, 0, 0);
    const y = new THREE.Vector3(0, 1, 0);
    const z = new THREE.Vector3(0, 0, 1);
    const axes_x = new THREE.ArrowHelper(x, o, 1.5*sf*b, 0xffff00);
    const axes_y = new THREE.ArrowHelper(y, o, 1.5*sf*b, 0xff00ff);
    const axes_z = new THREE.ArrowHelper(z, o, 1.5*sf*b, 0x00ffff);
    const light = new THREE.AmbientLight(0xf0f0f0);
    
    // common geometry and materials
    const line_material = new THREE.LineBasicMaterial({color: 0xffffff});

    // spacecraft
    const sc_geometry = new THREE.BoxGeometry(b, b, b);
    const sc_wire_geometry = new THREE.EdgesGeometry(sc_geometry);
    const sc_material = new THREE.MeshStandardMaterial({color: 0xaaaaaa});
    const sc = new THREE.Mesh(sc_geometry, sc_material);
    sc.renderOrder = 1;
    const sc_wireframe = new THREE.LineSegments(sc_wire_geometry, line_material);
    sc_wireframe.scale.set(1.001, 1.001, 1.001);  
    const actual_p = new THREE.ArrowHelper(p, new THREE.Vector3(0, 0, 0), sf*b, 0xff0000);

    // target
    const tsc_geometry = new THREE.BoxGeometry(b, b, b);
    const tsc_wire_geometry = new THREE.EdgesGeometry(sc_geometry);
    const tsc_material = new THREE.MeshStandardMaterial({color: 0xaaaaaa, transparent: true, opacity: 0.3});
    const tsc = new THREE.Mesh(tsc_geometry, tsc_material);
    const tsc_wireframe = new THREE.LineSegments(tsc_wire_geometry, line_material);
    const target_p = new THREE.ArrowHelper(p, new THREE.Vector3(0, 0, 0), sf*b, 0x00ff00); 
    tsc.scale.set(sf, sf, sf);
    tsc_wireframe.scale.set(sf, sf, sf);

    // dish
    const dish_geometry = new THREE.SphereGeometry(b, 16, 4, 0, 2*Math.PI, 0, 3*Math.PI/12);
    const dish_wire_geometry = new THREE.EdgesGeometry(dish_geometry);
    const dish_material = new THREE.MeshStandardMaterial({color: 0xeeeeee, transparent: true, opacity: 0.3, side: THREE.DoubleSide});
    const dish_line_material = new THREE.LineBasicMaterial({color: 0x000000, linewidth: 2});
    const dish = new THREE.Mesh(dish_geometry, dish_material);
    dish.position.set(0, -3*b/2, 0);
    const dish_wireframe = new THREE.LineSegments(dish_wire_geometry, dish_line_material);  
    dish_wireframe.position.set(0, -1.01*3*b/2, 0);
    dish_wireframe.scale.set(1.01, 1.01, 1.01);
    const dish_ax = new THREE.ArrowHelper(new THREE.Vector3(0, -1, 0), o, 1.5*sf*b, 0xff0000);

    // solar panels common geometry and materials
    const sp_geometry = new THREE.BoxGeometry(b, b, b/30);
    const sp_wire_geometry = new THREE.EdgesGeometry(sp_geometry);
    const sp_material = new THREE.MeshStandardMaterial({color: 0x000055, transparent: true, opacity: 0.3});
    const sp_line_material = new THREE.LineBasicMaterial({color: 0xbbbb00});

    // sp1a
    const sp1a = new THREE.Mesh(sp_geometry, sp_material);
    const sp1a_wireframe = new THREE.LineSegments(sp_wire_geometry, sp_line_material); 
    sp1a.position.set(b, 0, 0); 
    sp1a_wireframe.position.set(b, 0, 0); 
    sp1a_wireframe.scale.set(1.001, 1.001, 1.001);

    // sp1b
    const sp1b = new THREE.Mesh(sp_geometry, sp_material);
    const sp1b_wireframe = new THREE.LineSegments(sp_wire_geometry, sp_line_material);  
    sp1b.position.set(2*b, 0, 0); 
    sp1b_wireframe.position.set(2*b, 0, 0); 
    sp1b_wireframe.scale.set(1.001, 1.001, 1.001);

    // sp2a
    const sp2a = new THREE.Mesh(sp_geometry, sp_material);
    const sp2a_wireframe = new THREE.LineSegments(sp_wire_geometry, sp_line_material);  
    sp2a.position.set(-b, 0, 0); 
    sp2a_wireframe.position.set(-b, 0, 0); 
    sp2a_wireframe.scale.set(1.001, 1.001, 1.001);

    // sp2b
    const sp2b = new THREE.Mesh(sp_geometry, sp_material);
    const sp2b_wireframe = new THREE.LineSegments(sp_wire_geometry, sp_line_material); 
    sp2b.position.set(-2*b, 0, 0); 
    sp2b_wireframe.position.set(-2*b, 0, 0);  
    sp2b_wireframe.scale.set(1.001, 1.001, 1.001);

    // reaction wheels common geometry and materials
    const rw_geometry = new THREE.CylinderGeometry(0.05*b, 0.05*b, 0.05*b/3, 15, 5, false, 0, 2*Math.PI);
    const rw_wire_geometry = new THREE.EdgesGeometry(rw_geometry);

    // rw platform
    const rwp_r = 2*Math.sqrt(2)*rw_offset;
    const rwp_h = 0.7*rwp_r/Math.tan(beta);
    const rwp_geometry = new THREE.ConeGeometry(rwp_r, rwp_h, 4, 10, false, 0, 2*Math.PI);
    const rwp_wire_geometry = new THREE.EdgesGeometry(rwp_geometry);
    const rwp_material = new THREE.MeshStandardMaterial({color: 0xaaaaaa, transparent: true, opacity: 0.1});
    const rwp = new THREE.Mesh(rwp_geometry, rwp_material);
    rwp.rotateOnWorldAxis(x, Math.PI/2);
    rwp.rotateOnWorldAxis(z, Math.PI/4);
    const rwp_wireframe = new THREE.LineSegments(rwp_wire_geometry, line_material);  
    rwp_wireframe.rotateOnWorldAxis(x, Math.PI/2);
    rwp_wireframe.rotateOnWorldAxis(z, Math.PI/4);

    // rw1
    const rw1_material = new THREE.MeshStandardMaterial({color: 0xff0000});
    const rw1 = new THREE.Mesh(rw_geometry, rw1_material);
    rw1.rotateOnWorldAxis(x, Math.PI/2);
    rw1.position.set(rw_offset, 0, 0);
    rw1.rotateOnWorldAxis(y, Math.PI/2);
    rw1.rotateOnWorldAxis(y, -beta);
    const rw1_wireframe = new THREE.LineSegments(rw_wire_geometry, line_material);  
    rw1_wireframe.rotateOnWorldAxis(x, Math.PI/2);
    rw1_wireframe.position.set(rw_offset, 0, 0);
    rw1_wireframe.rotateOnWorldAxis(y, Math.PI/2);
    rw1_wireframe.rotateOnWorldAxis(y, -beta);
    const rw1_ax = new THREE.ArrowHelper(new THREE.Vector3(0, 1, 0).applyQuaternion(rw1.quaternion), rw1.position, sf*rw_offset, 0xff0000);

    // rw2
    const rw2_material = new THREE.MeshStandardMaterial({color: 0x00ff00});
    const rw2 = new THREE.Mesh(rw_geometry, rw2_material);
    rw2.rotateOnWorldAxis(x, Math.PI/2);
    rw2.position.set(-rw_offset, 0, 0);
    rw2.rotateOnWorldAxis(y, -Math.PI/2);
    rw2.rotateOnWorldAxis(y, beta);
    const rw2_wireframe = new THREE.LineSegments(rw_wire_geometry, line_material);  
    rw2_wireframe.rotateOnWorldAxis(x, Math.PI/2);
    rw2_wireframe.position.set(-rw_offset, 0, 0);
    rw2_wireframe.rotateOnWorldAxis(y, -Math.PI/2);
    rw2_wireframe.rotateOnWorldAxis(y, beta);
    const rw2_ax = new THREE.ArrowHelper(new THREE.Vector3(0, 1, 0).applyQuaternion(rw2.quaternion), rw2.position, sf*rw_offset, 0x00ff00);

    // rw3
    const rw3_material = new THREE.MeshStandardMaterial({color: 0x0000ff});
    const rw3 = new THREE.Mesh(rw_geometry, rw3_material);
    rw3.rotateOnWorldAxis(x, Math.PI/2);
    rw3.position.set(0, rw_offset, 0);
    rw3.rotateOnWorldAxis(x, -Math.PI/2);
    rw3.rotateOnWorldAxis(x, beta);
    const rw3_wireframe = new THREE.LineSegments(rw_wire_geometry, line_material);
    rw3_wireframe.rotateOnWorldAxis(x, Math.PI/2);
    rw3_wireframe.position.set(0, rw_offset, 0);
    rw3_wireframe.rotateOnWorldAxis(x, -Math.PI/2);
    rw3_wireframe.rotateOnWorldAxis(x, beta);  
    const rw3_ax = new THREE.ArrowHelper(new THREE.Vector3(0, 1, 0).applyQuaternion(rw3.quaternion), rw3.position, sf*rw_offset, 0x0000ff);

    // rw4
    const rw4_material = new THREE.MeshStandardMaterial({color: 0xffff00});
    const rw4 = new THREE.Mesh(rw_geometry, rw4_material);
    rw4.rotateOnWorldAxis(x, Math.PI/2);
    rw4.position.set(0, -rw_offset, 0);
    rw4.rotateOnWorldAxis(x, Math.PI/2);
    rw4.rotateOnWorldAxis(x, -beta);
    const rw4_wireframe = new THREE.LineSegments(rw_wire_geometry, line_material); 
    rw4_wireframe.rotateOnWorldAxis(x, Math.PI/2); 
    rw4_wireframe.position.set(0, -rw_offset, 0);
    rw4_wireframe.rotateOnWorldAxis(x, Math.PI/2);
    rw4_wireframe.rotateOnWorldAxis(x, -beta);
    const rw4_ax = new THREE.ArrowHelper(new THREE.Vector3(0, 1, 0).applyQuaternion(rw4.quaternion), rw4.position, sf*rw_offset, 0xffff00);

    // add to scene
    scene.add(light);
    //scene.add(axes_x);
    //scene.add(axes_y);
    //scene.add(axes_z);

    scene.add(sc);
    scene.add(sc_wireframe);
    scene.add(actual_p);

    scene.add(tsc);
    scene.add(tsc_wireframe);
    scene.add(target_p);

    tsc.rotateOnWorldAxis(z, Math.PI/6);
    tsc_wireframe.rotateOnWorldAxis(z, Math.PI/6);
    target_p.rotateOnWorldAxis(z, Math.PI/6);

    /*
    scene.add(dish);
    scene.add(dish_wireframe);
    scene.add(dish_ax);

    scene.add(sp1a);
    scene.add(sp1b);
    scene.add(sp2a);
    scene.add(sp2b);
    scene.add(sp1a_wireframe);
    scene.add(sp1b_wireframe);
    scene.add(sp2a_wireframe);
    scene.add(sp2b_wireframe);

    scene.add(rwp);
    scene.add(rwp_wireframe);

    scene.add(rw1);
    scene.add(rw2);
    scene.add(rw3);
    scene.add(rw4);
    scene.add(rw1_wireframe);
    scene.add(rw2_wireframe);
    scene.add(rw3_wireframe);
    scene.add(rw4_wireframe);
    scene.add(rw1_ax);
    scene.add(rw2_ax);
    scene.add(rw3_ax);
    scene.add(rw4_ax);
    */

    /**
     * animator
     */
    function animate(){
        requestAnimationFrame(animate);
        render();
    };

    function render() {
        renderer.render(scene, camera);
    }

    animate();    
}

export default animationrw