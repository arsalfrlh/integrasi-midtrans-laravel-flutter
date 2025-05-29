<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script
    type="text/javascript"
    src="https://app.sandbox.midtrans.com/snap/snap.js"
    data-client-key="{{ config('midtrans.client_key') }}">
  </script>
</head>

<body>
  <button id="pay-button">Pay!</button>

  <script type="text/javascript">
    var payButton = document.getElementById('pay-button');
    payButton.addEventListener('click', function () {
      if (typeof window.snap !== 'undefined') {
        window.snap.pay('{{ $snapToken }}'); // pakai snap.pay bukan embed
      } else {
        alert("Midtrans Snap belum siap.");
      }
    });
  </script>
</body>
</html>
