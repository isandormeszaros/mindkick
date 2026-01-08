import jwt from 'jsonwebtoken';

export const authenticateToken = (req, res, next) => {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];

    if (!token) return res.status(401).json({ error: "Nincs bejelentkezve!" });

    jwt.verify(token, process.env.JWT_SECRET || 'titkos_kulcs_fejleszteshez', (err, user) => {
        if (err) return res.status(403).json({ error: "Érvénytelen token!" });
        req.user = user;
        next();
    });
};

export const isAdmin = (req, res, next) => {
    if (req.user && req.user.role === 'admin') {
        next();
    } else {
        return res.status(403).json({ error: "Hozzáférés megtagadva! Ehhez admin jogosultság szükséges." });
    }
};