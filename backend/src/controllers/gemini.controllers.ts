import { ai } from "../index.js";
import type { Request, Response } from "express";


export const generateContent = async (req: Request, res: Response) => {

    const { prompt, history } = req.body;

    if (!prompt) return res.status(400).json({ message: 'user prompt is required' });

    if (!history) return res.status(400).json({ message: 'user history is required' });

    try {

        const chat = ai.chats.create({ model: "gemini-3-flash-preview", history: history });

        const stream = await chat.sendMessageStream({ message: prompt });

        for await (const chunk of stream) {
            res.write(`data : ${chunk.text}\n\n`);
        }

        res.end();

    } catch (error) {
        console.log(error);
        if (error instanceof Error) {
            return res.status(500).json({
                message: error.message
            })
        }
    }
}


