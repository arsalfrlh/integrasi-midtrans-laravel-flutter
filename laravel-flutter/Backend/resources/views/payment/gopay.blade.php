<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>
<body>
    <div class="container">
        <div class="card" style="width: 20rem;">
            <img class="card-img-top" src="{{ $payment['actions']['0']['url'] }}" alt="Card image cap">
            
            {{-- gunakan ini jika tanda (+ di dd()| dan charge di controllernya) <img class="card-img-top" src="{{ $payment->actions[0]->url }}" alt="QR Code"> --}}
            {{-- <input type="text" class="form-control" value="{{ $payment->order_id }}" readonly>
            <input type="text" class="form-control" value="{{ $payment->payment_type }}" readonly>
            <input type="text" class="form-control" value="{{ $payment->gross_amount }}" readonly>
            <input type="text" class="form-control" value="{{ $payment->transaction_time }}" readonly> --}}

            <div class="card-body">
                <h1>Data Pembayaran</h1>
                <div class="form-group">
                    <label for="formGroupExampleInput2">ORDER ID</label>
                    <input type="text" class="form-control" id="formGroupExampleInput2" value="{{ $payment['order_id'] }}" readonly>
                </div>
                <div class="form-group">
                    <label for="formGroupExampleInput2">Metode Pembayaran</label>
                    <input type="text" class="form-control" id="formGroupExampleInput2" value="{{ $payment['payment_type'] }}" readonly>
                </div>
                <div class="form-group">
                    <label for="formGroupExampleInput2">Total</label>
                    <input type="text" class="form-control" id="formGroupExampleInput2" value="{{ $payment['gross_amount'] }}" readonly>
                </div>
                <div class="form-group">
                    <label for="formGroupExampleInput2">Waktu Transaksi</label>
                    <input type="text" class="form-control" id="formGroupExampleInput2" value="{{ $payment['transaction_time'] }}" readonly>
                </div>
            </div>
        </div>
    </div>
</body>
</html>