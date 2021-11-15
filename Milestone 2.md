# Next Step

## Perintah yg belum

- [ ] saveGame dan LoadGame ( Terakhiran )
- Status
- Quest
- cekInventory
- Move (W,A,S,D)
- Ranch : Yg dapet kemaren
- Farm : Yg dapet kemaren
- Fish : yg dapet kemaren
- Market
- Quest
- House
- Throw Inventory

## Yg belum

- [ ] Set Role
- [ ]

## State Game

1. Role
2. Time
   - Day
   - Season: 1 season = 30 hari
   - State siang malam berdasarkan jumlah activity
     -> Jumlah Activity perindahan siang ke malam : 5
     -> Sleep langsung pindah day, tapi harus malem
3. Diary
   - Day berapa
   - Isi diarinya
   - data state: State, uangnya xp-nya
4. Uangnya bos
5. XP
6. Inventory
7. Location

> Ada setter dan getternya biar gampang.

## Quest

1 Quest tuh harus ngumpulin dari 3 produk.

questFishing(X) :- X = [ X, "Ikan Hiu", 10 ]

ID Product, ada listnya

## Tambahan

1. Print COlor dibuat kek fungsi
   setColor(Red).
   write(...).
   write(...).
   resetColor().
