# Dumpy danych referencyjnych

Pliki `*.dump` w katalogu `dumps/` to NDJSON (jeden dokument JSON na linię). Każdy plik trafia do kolekcji o tej samej nazwie.

## Import

```bash
MONGODB_URI=mongodb://localhost:27017/seeds ./import.sh
```

- Wymaga `mongoimport` (MongoDB Database Tools) w PATH.
- Każda kolekcja jest czyszczona przed importem (`--drop`), więc skrypt można uruchomić wielokrotnie.
- Skrypt importuje wszystkie pliki `*.dump` z `dumps/`, bez wyjątków.

## Kolekcje

| Kolekcja                           | Opis                                                                            |
|------------------------------------|---------------------------------------------------------------------------------|
| `countries`                        | Kraje (nazwy PL/EN, kody alpha2/alpha3/numeric, flaga SVG)                      |
| `crwde`                            | Wzory deklaracji (CRWDE), m.in. `identifier`, `signature`, `institutionName`    |
| `institution_types`                | Typy instytucji; `institutions.typeId` wskazuje na `_id`                        |
| `institutions`                     | Instytucje (REGON, NIP, adres, ESP); `typeId` -> `institution_types._id`        |
| `legal_acts`                       | Akty prawne (`identifier`, tytuł, link ELI)                                     |
| `legal_act_usages`                 | Liczniki użyć aktu (artykuły, instytucje, procedury); `_id` = `legal_acts._id`  |
| `legal_act_related_contents`       | Powiązane treści aktów (typ `institution`); `_id` = `institutions._id`          |
| `procedure_range_for_citizen`      | Zakres procedur dla obywatela (słownik)                                         |
| `procedure_range_for_entrepreneur` | Zakres procedur dla przedsiębiorcy (słownik)                                    |
| `territories`                      | Jednostki terytorialne (województwa, powiaty, gminy); `code`                    |
| `territories_cities`               | Miejscowości; `terc` zaczyna się od kodu województwa (`territories.code`)       |
| `territories_streets`              | Ulice; `terc` -> `territories_cities.terc`                                      |

