# Funkcionális Specifikáció – MindKick Quiz Platform

## 1. A rendszer céljai és nem céljai

A fejlesztés elsődleges célja egy modern, webes alapú kvízalkalmazás létrehozása, amely szórakoztató és interaktív módon teszi lehetővé a felhasználók számára a tudásuk tesztelését és bővítését. A rendszer a **gamifikáció** (játékosítás) eszközeivel – például pontgyűjtés és ranglista – motiválja a tanulást, miközben az adminisztrátorok számára egy átlátható, könnyen kezelhető felületet biztosít a tartalmak menedzselésére.

A rendszernek **reszponzívnak** kell lennie, biztosítva a zökkenőmentes működést asztali számítógépeken és mobileszközökön egyaránt. Kiemelt cél a **gyors visszajelzés**: a játékosok azonnal látják az eredményeiket, és ezek a pontszámok azonnal frissülnek a központi adatbázisban.

A rendszer különböző jogosultsági szinteket kezel:

* **Játékos (User):** kvízek böngészése és kitöltése
* **Adminisztrátor (Admin):** kvízek és felhasználók kezelése

### Nem célok

A fejlesztés jelen fázisában **nem cél**:

* Teljes körű oktatási keretrendszer (LMS) létrehozása
* Tananyagok, videóleckék vagy házi feladatok kezelése
* Offline működés biztosítása
* Fizetős funkciók vagy reklámok beépítése

A rendszer használatához **aktív internetkapcsolat szükséges**.

---

## 2. Használati esetek

### Felhasználói szerepkörök

* **Látogató:** Nem regisztrált érdeklődő
* **Játékos:** Regisztrált felhasználó, aki kvízeket tölt ki
* **Adminisztrátor:** Kiemelt jogkörrel rendelkező felhasználó

### Fő funkciók

* Adminisztrátorok új kvízeket hozhatnak létre (cím, leírás, nehézség)
* Kérdések és válaszok hozzárendelése kvízekhez
* Kvízek törlése kaszkádolt módon
* Játékosok regisztrálhatnak és bejelentkezhetnek
* Kvízek szűrése nehézségi szint szerint (Easy / Medium / Hard)
* Kvízek végigjátszása időkorláttal
* Pontszám és ranglista megtekintése
* Látogatók megtekinthetik a kvízek listáját, de játszani csak regisztráció után tudnak

### Előfeltételek

* A játék megkezdéséhez bejelentkezés szükséges
* Admin funkciók eléréséhez adatbázisban beállított jogosultság szükséges

---

## 3. Megfeleltetés – használati esetek és követelmények

* **K01, K02, K09 (Weboldal és UI):**
  React alapú frontend Tailwind CSS-sel biztosítja a modern megjelenést és a reszponzivitást. A kvízek kártyás elrendezésben jelennek meg, intuitív navigációval.

* **K03, K10 (Autentikáció és jogosultságkezelés):**
  JWT (JSON Web Token) alapú hitelesítés. A backend minden védett végponton ellenőrzi a token érvényességét és a felhasználó szerepkörét.

* **K04 (Játékmenet):**
  Dinamikus kvízmotor, nehézségtől függő időzítővel. Az utolsó másodpercekben vizuális visszajelzés (villogás) jelenik meg.

* **K05, K06 (Adminisztráció):**
  Admin felületen keresztül történik a kvízek kezelése. A törlés SQL szinten `ON DELETE CASCADE` megoldással történik, elkerülve az árva adatokat.

* **K07, K08 (Gamifikáció és adatkezelés):**
  A Ranglista a `user_stats` tábla alapján jelenik meg, az eredmények automatikusan mentésre kerülnek a kvíz végén.

---

## 4. Képernyőtervek

A felhasználói felület **komponens-alapú (React)**, egységes dizájnnal.

### Főbb oldalak

* **Kezdőlap (Home):**
  Kvízlista kártyás formában, felül nehézségi szűrősávval és *Start* gombokkal.

* **Bejelentkezés / Regisztráció:**
  Letisztult űrlapok, valós idejű hibaüzenetekkel.

* **Játék felület (QuizGame):**
  Kérdés középen, válaszlehetőségek alatta, jobb felső sarokban visszaszámláló.

* **Eredmény oldal (Result):**
  Pontszám, helyes/helytelen válaszok aránya, újrajátszás és ranglista gombok.

* **Ranglista (Leaderboard):**
  Táblázatos nézet, dobogós (arany–ezüst–bronz) kiemeléssel.

* **Admin Dashboard:**
  Kvízek listája szerkesztés és törlés funkciókkal, valamint *Új kvíz létrehozása* gomb.

---

## 5. Forgatókönyvek

### Látogató

* Megtekinti a Kezdőlapot
* Kvíz indításakor a rendszer bejelentkezésre irányítja

### Játékos

1. Bejelentkezik
2. Kiválaszt egy kvízt (pl. Medium nehézség)
3. Kérdések megjelennek időzítővel (pl. 20 mp)
4. Válaszadás kérdésenként
5. Eredmény oldal megjelenik
6. XP frissül, ranglistán előrelép

### Adminisztrátor

* Bejelentkezés után eléri az **Admin Panelt**

**Új kvíz létrehozása:**

* Cím megadása
* 5 kérdés hozzáadása
* Kérdésenként 4 válasz (helyes megjelölése)
* Mentés egyetlen adatbázis tranzakcióban

**Kvíz törlése:**

* Megerősítés után a kvíz és minden kapcsolódó adat törlődik
* A felhasználói eredmények (logok) is eltávolításra kerülnek

---

## 6. Funkció–követelmény megfeleltetés

| ID  | Verzió | Követelmény          | Funkció                                 |
| --- | ------ | -------------------- | --------------------------------------- |
| K01 | V1.0   | Modern weboldal      | React alapú SPA, Tailwind CSS           |
| K02 | V1.0   | Kvízlista és szűrés  | Dinamikus lista, kliensoldali szűrés    |
| K03 | V1.0   | Felhasználókezelés   | Regisztráció, login, JWT védelem        |
| K04 | V1.0   | Játékmenet           | Időzített kérdések, pontszámítás        |
| K05 | V1.0   | Adminisztráció       | Összetett kvízlétrehozó űrlap           |
| K06 | V1.0   | Adatbázis integritás | SQL kaszkádolt törlés                   |
| K07 | V1.0   | Gamifikáció          | Ranglista, statisztika frissítés        |
| K08 | V1.0   | Mobilbarát működés   | Reszponzív UI, hamburger menü           |
| K09 | V1.0   | Bővíthetőség         | Skálázható Node.js + MySQL architektúra |
| K10 | V1.0   | Biztonság            | Bcrypt, védett API végpontok            |

## 7. Képernyőtervek
![Főodal](/frontend/src/assets/images/home.png)
![Quizek](/frontend/src/assets/images/quizek.png)
![Leaderboard](/frontend/src/assets/images/leaderboard.png)
![Login](/frontend/src/assets/images/login.png)
![Register](/frontend/src/assets/images/Register.png)
![Running Quiz](/frontend/src/assets/images/running_quiz.png)
![Result](/frontend/src/assets/images/result.png)
