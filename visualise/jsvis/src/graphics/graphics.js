import * as THREE from "three";
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js';

/**
 * Sets up scene with camera, and renderer 
 * @param starting_camera_pos the starting y position of the camera
 * @return an array containing the scene, camera, renderer in that order
 */
function setupScene(starting_camera_pos){
    //setup new scene
    const scene = new THREE.Scene();
    
    //setup camera
    const camera = new THREE.PerspectiveCamera(75, window.innerWidth/window.innerHeight, 0.1);
    camera.position.copy(starting_camera_pos);
    camera.lookAt(new THREE.Vector3(0, 0, 0));

    //setup renderer
    const renderer = new THREE.WebGLRenderer();
    renderer.setSize(window.innerWidth, window.innerHeight);
    renderer.setPixelRatio(window.devicePixelRatio);

    renderer.shadowMap.enabled = true;
    renderer.shadowMap.type = THREE.PCFSoftShadowMap;

    //add controls
    // eslint-disable-next-line
    const controls = new OrbitControls(camera, renderer.domElement);

    return [scene, camera, renderer]
}

/**
 * Resizes a scene
 * @param camera the camera to be resized
 * @param renderer the renderer to be resized
 */
function resizeScene(camera, renderer){
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
  
    renderer.setSize(window.innerWidth, window.innerHeight);
};

/**
 * Loads a texture given an imported image object
 * @param {Image} image_object the image object
 * @return a texture object
 */
function loadTexture(image_object){
    const textureLoader = new THREE.TextureLoader();
    const texture = textureLoader.load(image_object)

    return texture
}

export {
    setupScene,
    resizeScene,
    loadTexture,
}