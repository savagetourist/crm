<?php

Route::group(['prefix' => 'auths', 'middleware' => []], function () {
    Route::get('login', 'LoginController@showLoginForm')->name('login');
    Route::post('login', 'LoginController@Login')->name('login.post');
});