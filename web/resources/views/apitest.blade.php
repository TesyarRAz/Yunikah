@extends('layouts.app')

@section('content')
<div class="container">
    <h2 class="text-center">Api Test</h2>

    <table class="w-100" cellpadding="5">
        <tr>
            <td>Masukan Link</td>
            <td>:</td>
            <td>
                <input type="text" id="link" class="form-control" value="http://localhost:8000/api/">
            </td>
        </tr>
        <tr>
            <td>Method</td>
            <td>:</td>
            <td>
                <input type="text" id="method" class="form-control" value="GET">
            </td>
        </tr>
        <tr>
            <td>Masukan Data</td>
            <td>:</td>
            <td>
                <textarea id="data" class="form-control"></textarea>
            </td>
        </tr>
        <tr>
            <td>Masukan Token</td>
            <td>:</td>
            <td>
                <textarea id="token" class="form-control"></textarea>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <button id="kerjakan" class="btn btn-primary">Kerjakan</button>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <textarea class="form-control" id="result" rows="8"></textarea>
            </td>
        </tr>
    </table>
</div>

<script type="text/javascript">
    (function() {
        let csrf_token = document.querySelector('meta[name=csrf-token]').content;
        let link = document.querySelector('#link');
        let data = document.querySelector('#data');
        let token = document.querySelector('#token');
        let result = document.querySelector('#result');
        let method = document.querySelector('#method')
        let kerjakan = document.querySelector('#kerjakan');

        kerjakan.onclick = () => {
            let input = {
                method: method.value,
                header: {
                    '_token' : csrf_token
                }
            }

            if (data.value.length > 0) input.body = data.value;
            if (token.value.length > 0) input.header['Authorization'] = 'Bearer ' + token.value;

            fetch(link.value, input)
            .then(e => e.text())
            .then(e => result.value = e);
        }
    })();
</script>
@endsection
