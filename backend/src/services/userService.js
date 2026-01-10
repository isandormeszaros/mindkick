import db from '../config/dboperations.js';

export const getUserProfileService = async (userId) => {

    const data = await db.getUserProfileData(userId);

    if (!data || !data.stats) {
        throw new Error("Nem található adat a felhasználóhoz.");
    }

    return {
        username: data.stats.display_name || data.stats.username,
        avatar: data.stats.avatar_url,
        stats: {
            totalScore: data.stats.total_score || 0,
            quizzesCompleted: data.stats.quizzes_completed || 0,
            streak: data.stats.current_streak || 0,
            perfectCount: data.stats.perfect_quizzes || 0,
            xp: (data.stats.total_score || 0) * 10
        },
        badges: {
            earned: data.badges || [],
            hasFirstQuiz: (data.stats.quizzes_completed || 0) > 0
        }
    };
};

export default {
    getUserProfileService
};