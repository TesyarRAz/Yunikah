@extends('layouts.app')

@section('modal')
<!-- For Modal Paket -->
<div id="modalPaket" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Pilih Paket</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form action="{{ route('paket.detail.store') }}" method="post">
            @csrf

            <input type="hidden" name="produk_id" id="produkId">
            <select class="form-control my-2" name="paket_id">
                @foreach ($paket as $p)
                    <option value="{{ $p->id }}">{{ $p->name }}</option>
                @endforeach
            </select>

            <button type="submit" class="btn btn-success">Tambahkan</button>
        </form>
      </div>
      <div class="modal-footer text-center">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
@endsection

@section('content')
<div class="container">
    @if (session()->has('status'))
        <div class="alert alert-warning">
            {{ session('status') }}
        </div>
    @endif
	<h2 class="text-center">Daftar Produk {{ $mitra->name }}</h2>
    <div class="row align-items-center">
        <div class="col-12 mx-auto">
            <div class="my-2 row justify-content-between">
                <div class="col">
                    <a class="btn btn-sm btn-secondary" href="{{ route('mitra.index') }}">Kembali</a>
                </div>
                <div class="col" align="right">
                    <a class="btn btn-sm btn-primary" href="{{ route('produk.create', $mitra->id) }}">
                        Tambah
                    </a>
                </div>
            </div>
        	<table class="table table-stripped table-white table-bordered table-responsive-sm">
        		<thead class="bg-dark text-white">
        			<tr>
        				<th>#</th>
        				<th>Nama</th>
                        <th>Type</th>
                        <th>Harga</th>
                        <th>Gambar</th>
                        <th>Opsi</th>
        			</tr>
        		</thead>
        		<tbody class="bg-white">
                    @php $i = 1; @endphp
        			@foreach ($data as $d)
                        <tr>
                            <td>{{ $i++ }}</td>
                            <td>{{ $d->name }}</td>
                            <td>{{ ucfirst(strtolower($d->type)) }}</td>
                            <td>
                            @if($d->type == 'tersedia')
                            Disediakan
                            @else
                            Rp. {{ number_format($d->harga, 2, ',', '.') }}
                            @endif
                            </td>
                            <td>
                                <a class="btn btn-sm btn-success @if(empty($d->image)) btn-disabled @endif" href="#" @if(!empty($d->image)) onclick="showModal('{{ asset('assets/images/' . $d->image->name)}}')" @endif>Buka</a>
                            </td>
                            <td>
                                @if ($d->type == 'custom')
                                    
                                @else
                                    <a class="btn btn-sm btn-primary" href="{{ route('produk.pilihan.index', [$mitra->id, $d->id]) }}">Detail</a>
                                @endif
                                <button class="btn btn-sm btn-info" onclick="showModalPaket({{ $d->id }})">Paketkan</button>
                                <a class="btn btn-sm btn-danger" href="{{ route('produk.edit', [$mitra->id, $d->id]) }}">Edit</a>
                                <button class="btn btn-sm btn-warning" onclick="$('#form-delete-{{ $d->id }}').submit()">Hapus</button>
                                <form id="form-delete-{{ $d->id }}" action="{{ route('produk.destroy', [$mitra->id, $d->id]) }}" method="POST" onsubmit="return confirm('Yakin ingin dihapus?')">
                                    @csrf
                                    @method('DELETE')
                                </form>
                            </td>
                        </tr>
                    @endforeach
        		</tbody>
        	</table>

            {{ $data->render() }}
        </div>
    </div>
</div>
<script type="text/javascript">
    function showModalPaket(produk_id) {
        var _modal = $("#modalPaket");
        var _produk = document.getElementById('produkId');

        _produk.value = produk_id;

        _modal.modal();
    }
</script>

@endsection