# Rendszerterv

## 1. A rendszer célja

Napjainkban az online tanulás és a gamifikáció egyre nagyobb teret hódít. A hagyományos, papíralapú vagy statikus online tesztek gyakran unalmasak, nem adnak azonnali visszajelzést, és hiányzik belőlük a versenyszellem. A **MindKick** projekt célja egy modern, webes alapú kvízalkalmazás létrehozása, amely élvezetessé teszi a tudásfelmérést.

A rendszer ötvözi a tanulást és a szórakozást: a felhasználók különböző nehézségi szinteken (**Easy, Medium, Hard**) tehetik próbára tudásukat, azonnali kiértékelést kapnak, és eredményeikkel felkerülhetnek egy globális ranglistára. A rendszer két fő felhasználói kört kezel:

* **Játékosok**, akik a kvízeket kitöltik
* **Adminisztrátorok**, akik a kvízeket és kérdéseket menedzselik

A rendszer kiemelt célja a **reszponzív működés**, amely mobilon és asztali környezetben is teljes értékű felhasználói élményt biztosít.

---

## 2. Projektterv

### 2.1 Projektszerepkörök és felelősségek

* **Scrum Master:** Mészáros Sándor
* **Product Owner:** Mészáros Sándor

### 2.2 Projektmunkások és feladatkörök

* **Frontend fejlesztés:** Majnár Patrik, Mészáros Sándor - React, Tailwind CSS, UI/UX
* **Backend fejlesztés:** Majnár Patrik, Mészáros Sándor - Node.js, Express, REST API
* **Adatbázis kezelés:** Majnár Patrik, Mészáros Sándor – MySQL, SQL lekérdezések
* **Tesztelés:** Majnár Patrik, Mészáros Sándor – Manuális és funkcionális tesztek

### 2.3 Ütemterv

| Funkció         | Feladat                                   | Prioritás | Becslés (nap) |
| --------------- | ----------------------------------------- | --------- | ------------- |
| Specifikáció    | Követelmény- és funkcionális specifikáció | 1         | 2             |
| Rendszerterv    | Rendszerterv kidolgozása                  | 1         | 2             |
| Adatbázis       | ERD és SQL scriptek                       | 1         | 1             |
| Backend alapok  | Node.js, Auth (JWT), API-k                | 2         | 3             |
| Frontend alapok | React init, routing, Auth UI              | 2         | 3             |
| Admin funkciók  | Kvíz CRUD, kaszkádolt törlés              | 3         | 4             |
| Játékmenet      | Kvízmotor, időzítő, pontszámítás          | 3         | 4             |
| Gamifikáció     | Ranglista, statisztikák                   | 4         | 2             |
| UI/UX           | Reszponzivitás, dizájn                    | 4         | 2             |
| Tesztelés       | Hibajavítás, végső teszt                  | 5         | 3             |

### 2.4 Mérföldkövek

* Dokumentációk elfogadása
* Backend és adatbázis működik
* Frontend–Backend integráció
* Admin panel és játékmenet kész
* Ranglista és végleges UI
* Kész rendszer átadása

---

## 3. Üzleti folyamatok modellje

### 3.1 Üzleti szereplők

* **Felhasználó (Játékos):** Kvízek kitöltése, pontgyűjtés, ranglista
* **Adminisztrátor:** Kvízek teljes körű kezelése

### 3.2 Üzleti folyamatok

A látogató megtekinti a kvízeket, de játék indításakor bejelentkezés szükséges. A játékos kiválaszt egy kvízt, végigjátssza időkorláttal, majd megkapja az eredményt. A pontszám frissül a profilban és a ranglistán.

Az adminisztrátor grafikus felületen hoz létre vagy töröl kvízeket. Törléskor a rendszer biztosítja az adatbázis integritását kaszkádolt törléssel.

---

## 4. Követelmények

### Követelménytáblázat

| ID | Modul       | Név            | Kifejtés                   |
| -- | ----------- | -------------- | -------------------------- |
| K1 | Szerver     | Adatbázis      | MySQL relációs adatbázis   |
| K2 | Felület     | Autentikáció   | JWT alapú bejelentkezés    |
| K3 | Felület     | Kvízlista      | Kártyás lista, szűrés      |
| K4 | Játék       | Kvíz motor     | Időzítő, kiértékelés       |
| K5 | Admin       | Létrehozás     | Összetett kvíz űrlap       |
| K6 | Admin       | Törlés         | Kaszkádolt törlés          |
| K7 | Statisztika | Ranglista      | XP alapú rangsor           |
| K8 | Felület     | Reszponzivitás | Mobil és desktop támogatás |

### Funkcionális követelmények

* Jelszavak hashelt tárolása
* Időzítő vizuális figyelmeztetése
* Automatikus pontszámítás
* Jogosultság-alapú hozzáférés

### Nem funkcionális követelmények

* API válaszidő < 200 ms
* Modern UI (Tailwind CSS)
* Skálázható adatbázis

---

## 5. Funkcionális terv

### 5.1 Rendszerszereplők

* **Vendég** – csak böngészés
* **Játékos** – teljes játékfunkciók
* **Admin** – tartalomkezelés

### 5.2 Menü-hierarchia

**Publikus:**

* Főoldal
* Bejelentkezés
* Regisztráció

**Játékos:**

* Játékfelület
* Eredmény oldal
* Ranglista
* Profil

**Admin:**

* Admin Dashboard
* Új kvíz létrehozása

---

## 6. Fizikai környezet

### Hardver

* Kliens: Internetképes eszközök
* Szerver: Node.js futtatására alkalmas környezet

### Fejlesztői eszközök

* VS Code
* Postman
* Git / GitHub
* MySQL Workbench / phpMyAdmin

---

## 7. Architektúrális terv

### Technológiai stack

* **Frontend:** React (Vite), Tailwind CSS, Axios
* **Backend:** Node.js, Express, JWT, bcrypt
* **Adatbázis:** MySQL

### Környezetek

* Fejlesztői: localhost (3000 / 8000)
* Éles: Felhő vagy VPS környezet

---

## 8. Adatbázis terv (vázlat)

* users
* user_stats
* quizzes
* questions
* quiz_questions
* options
* results

---

## 9. Implementációs terv

### Frontend

* Routing (App.js)
* Auth komponensek
* Quiz komponensek
* Admin oldalak

### Backend

* server.js
* auth / quiz route-ok
* DB műveletek
* Auth middleware

---

## 10. Tesztterv

* Unit tesztek
* Integrációs tesztek
* Rendszerteszt
* Admin funkciók tesztje
* Cross-browser teszt

---

## 11. Telepítési terv

* Node.js és MySQL telepítése
* DB script importálása
* Backend és frontend indítása

---

## 12. Karbantartási terv

* Tartalomfrissítés
* Monitorozás
* Hibajavítás
* Továbbfejlesztés (multiplayer, statisztikák)
