import React from 'react';
import * as THREE from "three";
import { setupScene, resizeScene } from '../graphics/graphics.js';
import { animationrw } from '../graphics/animations.js';

import '../css/App.css';

THREE.Object3D.DefaultUp.set(0, 0, 1);

class App extends React.Component{

  componentDidMount() {
    var scene;
    var camera; 
    var renderer;

    [scene, camera, renderer] = setupScene(new THREE.Vector3(-2, -2, -2));
    this.mount.appendChild(renderer.domElement);
    animationrw(scene, camera, renderer);

    window.addEventListener('resize', () => {resizeScene(camera, renderer)});
    }

  render(){
    return (
      <div className="App" ref={ref => (this.mount = ref)}></div>
    );
    }
}

export default App;