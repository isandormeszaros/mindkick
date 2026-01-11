# MindKick

Ez a projekt egy kvíz platform, ami a tanulást és a szórakozást ötvözi gamification elemekkel. A rendszer lehetőséget ad kvízek kitöltésére, személyes profilok létrehozására és kezelésére, illetve arra is, hogy a felhasználók közösségi szinten mérjék össze tudásukat és versenyezzenek egymással.

---

## Munkamegosztás

A projektet két fő fejlesztő készíti. A feladatok négy nagy funkcionális modulra lettek bontva. Mivel két fős a csapat, **Mészáros Sándor** végzi az 1., a 2. és a 3. modult, **Majnár Patrik** pedig 4. modult. A leosztás egyenlőtlenségének oka a harmadik csapattag távozása a projektből, emiatt a tapasztaltabb fejlesztő, Mészáros Sándor vállalta magára a feladatok elvégzését.

### Mészáros Sándor
**Felelősségi kör:** Core Gameplay + Social & Discovery

**1. Modul: Quiz Engine & Questions**
- Kérdések dinamikus megjelenítése, progress bar, válaszkezelés.
- Pontszámítás, részletes kiértékelés, konfetti animáció, "következő kvíz" ajánló.
- Játékállás mentése adatvesztés ellen.

**2. Modul: Admin Pages**
Az admin felület kizárólag **admin jogosultsággal** rendelkező felhasználók számára érhető el.

- Áttekintő statisztikák:
  - Regisztrált felhasználók száma
  - Aktív felhasználók száma
  - Kitöltött kvízek összesen
- Gyors navigáció:
  - Felhasználókezelés
  - Badge kezelés
  - Jogosultságok

**3. Modul: Discover & Leaderboard**
- Kiemelt és ajánlott kvízek, kategória szűrők.
- Globális ranglista, dobogós helyezések (Top 3) vizuális kiemelése.

---

### Majnár Patrik
**Felelősségi kör:** User System & Gamification

**3. Modul: User Profile & Badges**
- Bejelentkezés és Regisztráció űrlapok.
- Felhasználói adatok, saját statisztikák megjelenítése.
- Megszerzett badge (pl: streak, hibátlan kvíz) listázása.