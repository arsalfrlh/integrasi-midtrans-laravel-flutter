<?php

namespace App\Http\Controllers;

use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Midtrans\Config;
use Midtrans\Snap;
use Midtrans\CoreApi;
//dokumentasi payment bank "https://docs.midtrans.com/docs/coreapi-core-api-bank-transfer-integration"
//dokumentasi payment e wallet "https://docs.midtrans.com/docs/coreapi-e-money-integration"

class PaymentController extends Controller
{
    public function index(){
        return view('main.index');
    }

    public function createPayment(Request $request){
        $request->validate([
            'email' => 'required',
            'name' => 'required',
            'total' => 'required',
        ]);

        Config::$serverKey = config('midtrans.server_key');
        Config::$clientKey = config('midtrans.client_key');
        Config::$isProduction = config('midtrans.is_production');
        Config::$isSanitized = config('midtrans.is_3ds');

        $transaksi = [
            'transaction_details' => [
                'order_id' => 'ORDER-'.uniqid(),
                'gross_amount' => $request->total,
            ],
            'customer_details' => [
                'first_name' => $request->name,
                'email' => $request->email,
            ],
        ];

        $snapToken = Snap::getSnapToken($transaksi);
        return view('main.payment', ['snapToken' => $snapToken]);
    }

    public function createBank(){
        return view('main.bank');
    }

    public function paymentBank(Request $request){
    $request->validate([
        'name' => 'required',
        'email' => 'required',
        'gross_amount' => 'required',
        'bank_transfer' => 'required',
        'payment_type' => 'required',
    ]);

    $serverKey = config('midtrans.server_key');
    try {
        $response = Http::withBasicAuth($serverKey, '')->post('https://api.sandbox.midtrans.com/v2/charge', [ //withBasicAuth adlh Authorization "Basic Auth"| berisi serverkey midtrans| request method post| jika ingin server produksi "https://api.midtrans.com/v2/charge"
            'bank_transfer' => [ //data bank contoh|bca|bni|cimb
                'bank' => $request->bank_transfer,
            ],
            'payment_type' => $request->payment_type, //tipe pembayaran contoh bank_transfer|gopay|cstore|akulaku
            'transaction_details' => [ //berisi data "id barang yg di order" dan "total pembayaran"
                'order_id' => 'ORDER-'.uniqid(),
                'gross_amount' => $request->gross_amount,
            ],
            'customer_details' => [ //berisi data user yg melakuka pembayaran
                'first_name' => $request->name,
                'email' => $request->email,
            ],
            'custom_expiry' => [ //untuk mengkostum expire pembayaran
            'order_time' => now()->format('Y-m-d H:i:s O'), // waktu saat ini + zona waktu
            'expiry_duration' => 24,
            'unit' => 'hour'
            ],
        ]);
        // dd($response->json());
        $data = $response->json();
        return view('payment.bank',['payment' => $data]);
    } catch(Exception $e){
        dd('Error Midtrans: '.$e->getMessage());
    }
    }

    public function createGopay(){
        return view('main.gopay');
    }

    public function paymentGopay(Request $request){
    $request->validate([
        'name' => 'required',
        'email' => 'required',
        'gross_amount' => 'required',
        'payment_type' => 'required',
    ]);

    $serverKey = config('midtrans.server_key');
    try {
        $response = Http::withBasicAuth($serverKey, '')->post('https://api.sandbox.midtrans.com/v2/charge',[
            'payment_type' => $request->payment_type,
            'transaction_details' => [
                'order_id' => 'ORDER-'.uniqid(),
                'gross_amount' => $request->gross_amount,
            ],
            'customer_details' => [
                'first_name' => $request->name,
                'email' => $request->email,
            ],
        ]);

        
    $data = $response->json();
    return view('payment.gopay', ['payment' => $data]);

    //bisa juga menggunakan ini
    // Config::$serverKey = config('midtrans.server_key');
    // $params = [
    //     'transaction_details' => [
    //         'order_id' => rand(),
    //         'gross_amount' => 10000,
    //     ],
    //     'payment_type' => 'gopay',
    //     'gopay' => [
    //         'enable_callback' => true,                // optional
    //         'callback_url' => 'someapps://callback'   // optional
    //     ]
    // ];
    // $response = CoreApi::charge($params);
    // return view('payment.gopay', ['payment' => $response]);

    }catch(Exception $e){
        dd('Error Midtrans: '.$e->getMessage());
    }
    }

}
