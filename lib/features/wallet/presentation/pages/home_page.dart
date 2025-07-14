import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:send_money_app/core/constants/app_colors.dart';
import 'package:send_money_app/features/wallet/domain/entities/transaction.dart';
import 'package:send_money_app/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:send_money_app/features/wallet/presentation/cubit/wallet_state.dart';
import 'package:send_money_app/features/wallet/presentation/cubit/transactions_cubit.dart';
import 'package:send_money_app/features/wallet/presentation/cubit/transactions_state.dart';
import 'package:send_money_app/features/wallet/presentation/pages/send_money_page.dart';
import 'package:send_money_app/features/wallet/presentation/pages/transactions_page.dart';
import 'package:send_money_app/features/wallet/presentation/widgets/balance_card.dart';
import 'package:send_money_app/features/wallet/presentation/widgets/shimmer_widget.dart';
import 'package:send_money_app/injection/injection_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<TransactionsCubit>()..loadTransactions(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: BlocBuilder<WalletCubit, WalletState>(
            builder: (context, state) {
                          if (state is WalletLoading) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    // Header shimmer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerWidget.rounded(
                              height: 14,
                              width: 100,
                              borderRadius: 4,
                            ),
                            const SizedBox(height: 8),
                            ShimmerWidget.rounded(
                              height: 24,
                              width: 120,
                              borderRadius: 4,
                            ),
                          ],
                        ),
                        const ShimmerWidget.circular(
                          width: 48,
                          height: 48,
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    // Balance card shimmer
                    const ShimmerBalanceCard(),
                    const SizedBox(height: 32),
                    // Quick actions title shimmer
                    ShimmerWidget.rounded(
                      height: 20,
                      width: 120,
                      borderRadius: 4,
                    ),
                    const SizedBox(height: 16),
                    // Quick action cards shimmer
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 110,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  offset: const Offset(0, 2),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ShimmerWidget.rounded(
                                  width: 52,
                                  height: 52,
                                  borderRadius: 16,
                                ),
                                const SizedBox(height: 10),
                                ShimmerWidget.rounded(
                                  height: 14,
                                  width: 50,
                                  borderRadius: 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            height: 110,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  offset: const Offset(0, 2),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ShimmerWidget.rounded(
                                  width: 52,
                                  height: 52,
                                  borderRadius: 16,
                                ),
                                const SizedBox(height: 10),
                                ShimmerWidget.rounded(
                                  height: 14,
                                  width: 50,
                                  borderRadius: 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Recent activity shimmer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShimmerWidget.rounded(
                          height: 20,
                          width: 140,
                          borderRadius: 4,
                        ),
                        ShimmerWidget.rounded(
                          height: 16,
                          width: 60,
                          borderRadius: 4,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: const [
                          ShimmerTransactionCard(),
                          SizedBox(width: 12),
                          ShimmerTransactionCard(),
                        ],
                      ),
                    ),
                  ],
                ),
              );
              } else if (state is WalletError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.error.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.error_outline,
                            color: AppColors.error,
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Oops! Something went wrong',
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.message,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: () {
                            context.read<WalletCubit>().loadWallet();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                          ),
                          child: const Text('Try Again'),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (state is WalletLoaded) {
                return _buildContent(context, state);
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, WalletLoaded state) {
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async {
        // Refresh both wallet and transactions
        context.read<WalletCubit>().loadWallet();
        context.read<TransactionsCubit>().loadTransactions();
        // Wait a bit to show the refresh animation
        await Future.delayed(const Duration(milliseconds: 500));
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BalanceCard(
                    balance: state.wallet.balance,
                    isVisible: state.wallet.isBalanceVisible,
                    onToggleVisibility: () {
                      context.read<WalletCubit>().toggleBalance();
                    },
                  ),
                ),
                const SizedBox(height: 28),
                _buildQuickActions(context),
                const SizedBox(height: 28),
                _buildRecentActivity(context),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good Morning,',
                style: GoogleFonts.poppins(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'John Doe',
                style: GoogleFonts.poppins(
                  color: AppColors.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: AppColors.cardShadow,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: AppColors.textPrimary,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildActionCard(
                  context: context,
                  icon: Icons.send_rounded,
                  label: 'Send',
                  color: AppColors.primary,
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SendMoneyPage(),
                      ),
                    );
                    
                    if (result == true) {
                      // Reload both wallet and transactions
                      context.read<WalletCubit>().loadWallet();
                      context.read<TransactionsCubit>().loadTransactions();
                    }
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildActionCard(
                  context: context,
                  icon: Icons.history_rounded,
                  label: 'History',
                  color: AppColors.accent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TransactionsPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 110,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                offset: const Offset(0, 2),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 26,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                label,
                style: GoogleFonts.poppins(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    return BlocBuilder<TransactionsCubit, TransactionsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Activity',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TransactionsPage(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                    ),
                    child: Text(
                      'See all',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            if (state is TransactionsLoading)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const ShimmerTransactionCard(),
                    const SizedBox(width: 12),
                    const ShimmerTransactionCard(),
                    const SizedBox(width: 12),
                    const ShimmerTransactionCard(),
                  ],
                ),
              )
            else if (state is TransactionsLoaded)
              if (state.transactions.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        Icon(
                          Icons.receipt_long_outlined,
                          size: 48,
                          color: AppColors.textLight,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No transactions yet',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: state.transactions
                        .take(5) // Show only recent 5 transactions
                        .map((transaction) {
                      final isSent = transaction.type == TransactionType.send;
                      return Padding(
                        padding: EdgeInsets.only(
                          right: state.transactions.indexOf(transaction) < 4 ? 12 : 0,
                        ),
                        child: _buildTransactionCard(
                          transaction: transaction,
                          icon: isSent
                              ? Icons.arrow_upward_rounded
                              : Icons.arrow_downward_rounded,
                          title: isSent ? 'To Jane Smith' : 'From Alex Johnson',
                          amount: '\$${transaction.amount.toStringAsFixed(2)}',
                          time: _formatDateTime(transaction.timestamp),
                          isSent: isSent,
                        ),
                      );
                    }).toList(),
                  ),
                )
            else if (state is TransactionsError)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Text(
                    'Failed to load transactions',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildTransactionCard({
    required Transaction transaction,
    required IconData icon,
    required String title,
    required String amount,
    required String time,
    required bool isSent,
  }) {
    final color = isSent ? AppColors.sendMoney : AppColors.receiveMoney;
    
    return Container(
      width: 280,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppColors.cardShadow,
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  time,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${isSent ? '-' : '+'}$amount',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'Just now';
        }
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '${weeks}w ago';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }
} 