// Mocks generated by Mockito 5.4.6 from annotations
// in send_money_app/test/features/wallet/presentation/cubit/wallet_cubit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:send_money_app/core/errors/failures.dart' as _i6;
import 'package:send_money_app/core/usecases/usecase.dart' as _i8;
import 'package:send_money_app/features/wallet/domain/entities/wallet.dart'
    as _i7;
import 'package:send_money_app/features/wallet/domain/repositories/wallet_repository.dart'
    as _i2;
import 'package:send_money_app/features/wallet/domain/usecases/get_wallet.dart'
    as _i4;
import 'package:send_money_app/features/wallet/domain/usecases/toggle_balance_visibility.dart'
    as _i9;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeWalletRepository_0 extends _i1.SmartFake
    implements _i2.WalletRepository {
  _FakeWalletRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetWallet].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWallet extends _i1.Mock implements _i4.GetWallet {
  MockGetWallet() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.WalletRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeWalletRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.WalletRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.Wallet>> call(_i8.NoParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, _i7.Wallet>>.value(
            _FakeEither_1<_i6.Failure, _i7.Wallet>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.Wallet>>);
}

/// A class which mocks [ToggleBalanceVisibility].
///
/// See the documentation for Mockito's code generation for more information.
class MockToggleBalanceVisibility extends _i1.Mock
    implements _i9.ToggleBalanceVisibility {
  MockToggleBalanceVisibility() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.WalletRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeWalletRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.WalletRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.Wallet>> call(
          _i9.ToggleBalanceParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, _i7.Wallet>>.value(
            _FakeEither_1<_i6.Failure, _i7.Wallet>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.Wallet>>);
}
