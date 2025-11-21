import express from "express";
import cors from "cors";
import quizRouter from "./src/routes/quizRouter.js";
import dotenv from "dotenv";
dotenv.config();

const app = express();

app.use(cors({
  origin: "http://localhost:3000"
}));

app.use(express.json());

app.use("/quiz", quizRouter);

app.use((err, req, res, next) => {
  console.error("SERVER ERROR:", err);
  res.status(500).json({ error: "Server error" });
});

const PORT = process.env.PORT;
app.listen(PORT, () => console.log(`Backend running on port ${PORT}`));

export default app;