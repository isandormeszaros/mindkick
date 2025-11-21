import dotenv from "dotenv";

dotenv.config();

const config = {
  connectionLimit: 1000,
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_NAME,
  port: process.env.DB_PORT,
  dateStrings: true,
};

export default config;