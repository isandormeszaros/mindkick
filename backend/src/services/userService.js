import db from '../config/dboperations.js';

export const getUserProfileService = async (userId) => {
    // Két kérés párhuzamosan a gyorsaságért
    const [profileData, categoryStats] = await Promise.all([
        db.getUserProfileData(userId),
        db.getCategoryStatistics(userId)
    ]);

    if (!profileData || !profileData.stats) {
        throw new Error("Felhasználó nem található");
    }

    return {
        username: profileData.stats.username,
        avatar: profileData.stats.avatar_url,
        stats: {
            totalScore: profileData.stats.total_score || 0,
            streak: profileData.stats.current_streak || 0,
            quizzesCompleted: profileData.stats.quizzes_completed || 0,
            perfectCount: profileData.stats.perfect_quizzes || 0,
            xp: (profileData.stats.total_score || 0) * 10
        },
        badges: {
            earned: profileData.badges || [],
            hasFirstQuiz: (profileData.stats.quizzes_completed || 0) > 0
        },
        categoryStats: categoryStats || []
    };
};

export default {
    getUserProfileService
};