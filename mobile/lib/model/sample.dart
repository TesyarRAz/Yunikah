// import 'dart:math';

// import 'package:yunikah/model/asset.dart';
// import 'package:yunikah/model/iklan.dart';
// import 'package:yunikah/model/kategori.dart';
// import 'package:yunikah/model/mitra.dart';
// import 'package:yunikah/model/paket.dart';
// import 'package:yunikah/model/pemesanan.dart';
// import 'package:yunikah/network.dart';

// final kListStatusKategori = [
//   StatusKategori(
//     id: 1,
//     name: 'Rias',
//     image: Asset(
//       link: "${Network.RANDOM_IMAGE_LINK}/32"
//     )
//   ),
//   StatusKategori(
//     id: 2,
//     name: 'Hiburan',
//     image: Asset(
//       link: "${Network.RANDOM_IMAGE_LINK}/37"
//     )
//   ),
//   StatusKategori(
//     id: 3,
//     name: 'Undangan',
//     image: Asset(
//       link: "${Network.RANDOM_IMAGE_LINK}/76"
//     )
//   ),
//   StatusKategori(
//     id: 4,
//     name: 'Tenda',
//     image: Asset(
//       link: "${Network.RANDOM_IMAGE_LINK}/56"
//     )
//   ),
//   StatusKategori(
//     id: 5,
//     name: 'Photo',
//     image: Asset(
//       link: "${Network.RANDOM_IMAGE_LINK}/45"
//     )
//   ),
//   StatusKategori(
//     id: 6,
//     name: 'Catering',
//     image: Asset(
//       link: "${Network.RANDOM_IMAGE_LINK}/25"
//     )
//   )
// ];

// final kListMitra = List.generate(10, (index) => Mitra(
//   id: index,
//   name: 'Mitra #$index',
//   image: Asset(
//     link: "${Network.RANDOM_IMAGE_LINK}/${index + 23}"
//   )
// ));

// final kListIklan = List.generate(5, (index) => Iklan(
//     id: index,
//     name: "Iklan #$index",
//     image: Asset(
//       id: Random().nextInt(10),
//       name: "Image #$index",
//       link: "${Network.RANDOM_IMAGE_LINK}/$index"
//     )
//   )
// );

// final kListKategori = kListStatusKategori.map((statusKategori) => List.generate(5, (index) => Kategori(
//     id: Random().nextInt(999),
//     harga: 10000 * index,
//     name: "${statusKategori.name} #$index",
//     type: KategoriType.COMBO,
//     status: statusKategori,
//     image: Asset(
//       link: "${Network.RANDOM_IMAGE_LINK}/$index"
//     ),
//     data: List.generate(3, (index) => DataKategori(
//       name: "Data $index",
//       harga: 10000 * index
//     )),
//     mitra: kListMitra[Random().nextInt(kListMitra.length)],
//     keterangan: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
//   )
// )).expand((pair) => pair).toList();

// final kListPaket = List.generate(10, (index) => Paket(
//     harga: Random().nextInt(10) * 200000,
//     id: Random().nextInt(999),
//     name: "Paket #$index",
//     image: Asset(
//       link: "${Network.RANDOM_IMAGE_LINK}/$index"
//     ),
//     data: () {
//       List<Kategori> shuffle = []..addAll(kListKategori)..shuffle();

//       return shuffle.getRange(0, 10).map((kategori) => DataPaket(
//         kategori: kategori,
//         name: kategori.name
//       )).toList();
//     }()
//   )
// );

// final kListPemesanan = List.generate(3, (index) => Pemesanan(
//   id: index,
//   data: List.generate(3, (index) => DataPemesanan(
//     id: Random().nextInt(999),
//     kategori: kListKategori[Random().nextInt(999)]
//   ))
// ));