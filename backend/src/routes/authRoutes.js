import express from 'express';
import { getUserProfile, getAllBadges, getUserBadges } from '../controllers/userController.js';

import { authenticateToken } from '../middlewares/authMiddleware.js';

const router = express.Router();

router.get('/profile', authenticateToken, getUserProfile);

router.get('/badges', getAllBadges);
router.get('/:id/badges', getUserBadges);

export default router;