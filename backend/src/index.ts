import express, { type Express } from 'express';
import bodyParser from 'body-parser';
import dotenv from 'dotenv';
import http, { type Server } from 'http';
import { GoogleGenAI } from "@google/genai";

import geminiRoutes from './routes/gemini.routes.js';

const app: Express = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.set('PORT', 3000);
app.set('BASE_URL', 'localhost');

dotenv.config();

app.use('/api/v1', geminiRoutes);

const server: Server = http.createServer(app);

server.listen(app.get('PORT'), () => {
    console.log(`Server stated at port ${app.get('PORT')}`)
});

export const ai = new GoogleGenAI({});
export default server;