# Next Step

## Todo List

<!-- - [ ] saveGame dan LoadGame ( Terakhiran ) -->

- [x] Status
- [x] Quest

- [x] Move (W,A,S,D)

- [ ] Ranch : Yg dapet kemaren
- [x] Farm : Yg dapet kemaren
- [x] Fish : yg dapet kemaren

- [x] Market
- [ ] Alchemist
- [x] House

- [x] cekInventory
- [ ] Throw Inventory

- [ ] Equipment
- [x] Quest
- [x] Time
- [ ] Add Test
- [x] levelUp -> setiap dapet exp dari action
- [ ] checkQuest. -> simpen di setiap action yang mendapat product
- [ ] updata energi dan ++kegiatan
- [ ] ganti Time
- [ ] retract Exit

- [x] Set Role
- [x] State Game : Rada segera!
- [x] Color Printer
- [x] Quest Ranch
- [x] Quest Farm
- [x] Quest Fish
- [x] Save game

## State Game

> Ada setter dan getternya biar gampang.

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
8. Hotbar - Tangannya (3 Equipment)

## Quest

1 Quest tuh harus ngumpulin dari 3 produk.

```prolog
questFishing(X) :- X = [ X, "Ikan Hiu", 10 ]
```

ID Product, ada listnya

## Pembagian

1. Orang 1

   - Status
   - Set Role
   - State game
   - Move

2. Orang 2

   - Ranch
   - Market
   - Quest Ranch Randomizer
   - Equipment Changer

3. Orang 3

   - Farm
   - Inventrory
   - Quest Farm Randomizer
   - Quest

4. Orang 4
   - Fish
   - House
   - Quest Fish Randomizer
   - Alchemist

## Modal

1. Berupa gold: 100 G
2. Equipment yg dipakenya
