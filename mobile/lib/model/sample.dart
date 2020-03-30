import 'dart:math';

import 'package:yunikah/model/asset.dart';
import 'package:yunikah/model/iklan.dart';
import 'package:yunikah/model/kategori.dart';
import 'package:yunikah/model/mitra.dart';
import 'package:yunikah/network.dart';

final kListStatusKategori = [
  StatusKategori(
    id: 1,
    name: 'Rias',
    image: Asset(
      link: "${Network.RANDOM_IMAGE_LINK}/32"
    )
  ),
  StatusKategori(
    id: 2,
    name: 'Hiburan',
    image: Asset(
      link: "${Network.RANDOM_IMAGE_LINK}/37"
    )
  ),
  StatusKategori(
    id: 3,
    name: 'Undangan',
    image: Asset(
      link: "${Network.RANDOM_IMAGE_LINK}/76"
    )
  ),
  StatusKategori(
    id: 4,
    name: 'Tenda',
    image: Asset(
      link: "${Network.RANDOM_IMAGE_LINK}/56"
    )
  ),
  StatusKategori(
    id: 5,
    name: 'Photo',
    image: Asset(
      link: "${Network.RANDOM_IMAGE_LINK}/45"
    )
  ),
  StatusKategori(
    id: 6,
    name: 'Catering',
    image: Asset(
      link: "${Network.RANDOM_IMAGE_LINK}/25"
    )
  )
];

final kListMitra = List.generate(10, (index) => Mitra(
  id: index,
  name: 'Mitra #$index',
  image: Asset(
    link: "${Network.RANDOM_IMAGE_LINK}/${index + 23}"
  )
));

final kListIklan = List.generate(5, (index) => Iklan(
    id: index,
    name: "Iklan #$index",
    image: Asset(
      id: Random().nextInt(10),
      name: "Image #$index",
      link: "${Network.RANDOM_IMAGE_LINK}/$index"
    )
  )
);