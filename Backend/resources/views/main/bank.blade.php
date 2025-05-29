<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>
<body>
    <div class="container">
        <h1>Data Pembeli</h1>
        <div class="card" style="width: 40rem;">
            <div class="card-body">
                @if ($errors->any())
                    <div class="pt-3 alert-danger">
                        <ul>
                            @foreach ($errors->all() as $item)
                                <li>{{ $item }}</li>
                            @endforeach
                        </ul>
                    </div>
                @endif
                <form action="/payment/bank/proses" method="POST">
                    @csrf
                    <div class="form-group">
                        <label for="formGroupExampleInput">Nama</label>
                        <input type="text" class="form-control" id="formGroupExampleInput" placeholder="Nama Anda" name="name">
                    </div>
                    <div class="form-group">
                        <label for="formGroupExampleInput2">Email</label>
                        <input type="text" class="form-control" id="formGroupExampleInput2" placeholder="Email Anda" name="email">
                    </div>
                    <div class="form-group">
                        <label for="formGroupExampleInput2">Harga</label>
                        <input type="text" class="form-control" id="formGroupExampleInput2" placeholder="Harga" name="gross_amount">
                    </div>
                    <div class="form-group">
                        <label for="formGroupExampleInput2">BANK</label>
                        <select name="bank_transfer" class="form-control">
                            <option value="bca">BCA</option>
                            <option value="bni">BNI</option>
                            <option value="cimb">CIMB</option>
                            <option value="permata">PERMATA</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <input type="hidden" value="bank_transfer" name="payment_type"> <!-- Karena di tampilan ini kshusus bank maka "payment_type" adalah "bank_transfer" isi valuenya harus sesuai dgn method payment -->
                        <input type="submit" value="Bayar" class="btn btn-primary">
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>