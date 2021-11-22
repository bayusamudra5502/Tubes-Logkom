/* Ranching */
:- dynamic(ranchProduct/5).

/*Facts*/
/*Product Ranching*/
/* ID Item, AnimalCode, Icon, Nama, Harga, EXP gained, waktu */
ranchProduct(r1, r4, '🥚', 'Telur', 50, 10, 3).
ranchProduct(r2, r5, '🧶', 'Wool', 100, 20, 4).
ranchProduct(r3, r6, '🥛', 'Susu', 200, 40, 5).

/*Animals*/
/*ID Animals, Icon, Nama, harga*/
ranchAnimals(r4, '🐔', 'Ayam', 500).
ranchAnimals(r5, '🐑', 'Domba', 1000).
ranchAnimals(r6, '🐄', 'Sapi', 1500).

/* Util */
/*ID Item, icon, nama, price, exp*/
ranchItem(r7, '📦', 'Crate', 300, 5).
ranchItem(r8, '✂️', 'Sheer', 600, 5).
ranchItem(r9, '🪣', 'Bucket', 800, 5).