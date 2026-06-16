import { Router } from "express";
import { generateContent } from "../controllers/gemini.controllers.js";


const router = Router();

router.post('/generate', generateContent);

export default router;