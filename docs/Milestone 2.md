# Next Step

## Perintah yg belum

<!-- - [ ] saveGame dan LoadGame ( Terakhiran ) -->

- [ ] Status
- [ ] Quest : Pake dummy aja dulu

- [ ] Move (W,A,S,D)

- [ ] Ranch : Yg dapet kemaren
- [ ] Farm : Yg dapet kemaren
- [ ] Fish : yg dapet kemaren

- [ ] Market
- [ ] Alchemist
- [ ] House

- [ ] cekInventory
- [ ] Throw Inventory
- [ ] Equipment

## Todo List

- [ ] Set Role
- [ ] State Game : Rada segera!
- [ ] Color Printer
- [ ] Quest Ranch
- [ ] Quest Farm
- [ ] Quest Fish

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
   - Inventrory
   - Quest Ranch Randomizer
   - Equipment Changer

3. Orang 3

   - Farm
   - Market
   - Quest Farm Randomizer

4. Orang 4
   - Fish
   - House
   - Quest Fish Randomizer

- Alchemist masuk kemana? kemarin belum ditambahin??
## Modal

1. Berupa gold: 100 G
2. Equipment yg dipakenya
