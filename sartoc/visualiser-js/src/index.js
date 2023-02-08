import ReactDOM from 'react-dom/client';

import { App } from './components/components.js';

import './css/index.css';

const container = document.getElementById('root');

const root = ReactDOM.createRoot(container);

root.render(<App/>);