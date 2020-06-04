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
                <button class="btn btn-primary" onclick="kerjakan()">Kerjakan</button>
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
    var link = document.getElementById('link');
    var data = document.getElementById('data');
    var token = document.getElementById('token');
    var result = document.getElementById('result');
    var method = document.getElementById('method')

    async function kerjakan() {
        let input = {
            method: method.value
        }

        if (input.method.toLowerCase() != 'get')
        {
            input.header = {
                '_token' : await fetch('http://localhost:8000/sanctum/csrf-cookie')
            }
        }

        if (data.value.length > 0) input.data = data.value;
        if (token.value.length > 0) input.header['Authorization'] = 'Bearer ' + token.value;

        console.log(input);

        await fetch(link.value, input)
        .then(e => e.text())
        .then(e => result.value = e);
    }
</script>
@endsection
