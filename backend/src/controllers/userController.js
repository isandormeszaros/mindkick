import * as userService from '../services/userService.js';

export const getUserProfile = async (req, res) => {
    try {
       const userId = req.user.id;
        const user = await userService.getUserProfileService(userId);

        if (!user) {
            return res.status(404).json({ error: "Felhasználó nem található" });
        }
        res.status(200).json(user);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Hiba a profil lekérésekor" });
    }
};

export const getAllBadges = async (req, res) => {
    try {
        const badges = await userService.getAllBadgesService();
        res.status(200).json(badges);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Hiba a jelvények lekérésekor" });
    }
};

export const getUserBadges = async (req, res) => {
    try {
        const userId = req.params.id;
        const earnedBadges = await userService.getUserEarnedBadgesService(userId);
        res.status(200).json(earnedBadges);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Hiba a megszerzett jelvények lekérésekor" });
    }
};