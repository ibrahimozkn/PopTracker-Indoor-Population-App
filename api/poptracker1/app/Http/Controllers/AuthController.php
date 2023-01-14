<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Fascades\Hash;
use Illuminate\Support\Facades\Auth;
use Illuminate\Database\QueryException;
use App\Models\User;


class AuthController extends Controller{

    public function register(Request $request) {
        $fields = $request->validate([
            'name' => 'required|string',
            'email' => 'required|string|unique:users,email',
            'password' => 'required|string|confirmed'
        ]);

        try{
            $user = User::create([
                'name' => $fields['name'],
                'email' => $fields['email'],
                'password' => bcrypt($fields['password'])
            ]);
        }
        catch(QueryException $err){
            $response = [
                'message' => 'User couldn\'t be created!',
                'error' => $err
            ];

            return response($response, 500);
        }


        $response = [
            'message' => 'User created successfully!'
        ];

        return response($response, 201);
    }

    public function login(Request $request) {
        $fields = $request->validate([
            'email' => 'required|string',
            'password' => 'required|string'
        ]);

        // Check if user exists

        if(Auth::attempt($fields)) {
            $user = User::where('email', $fields['email'])->first();

            $token = $user->createToken('myapptoken')->plainTextToken;
            $role = $user->is_admin;

            $response = [
                'token' => $token,
                'role' => $role
            ];

            return response($response, 200);
        }

        return response(['message' => 'Authentication error, account does not exist!'], 401);

    }

    public function logout() {
        auth()->user()->tokens()->delete();

        return [
            'message' => 'Logged out'
        ];
    }
}