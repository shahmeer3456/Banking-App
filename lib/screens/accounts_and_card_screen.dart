import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/card_model.dart';
import '../services/card_service.dart';
import '../widgets/custom_elevatedbutton.dart';
import '../utilities/colors.dart';

class AccountsAndCardScreen extends StatefulWidget {
  const AccountsAndCardScreen({Key? key}) : super(key: key);

  @override
  _AccountsAndCardScreenState createState() => _AccountsAndCardScreenState();
}

class _AccountsAndCardScreenState extends State<AccountsAndCardScreen> {
  final _cardService = CardService();
  bool _isLoading = false;
  List<CardModel> _cards = [];

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  Future<void> _loadCards() async {
    setState(() => _isLoading = true);
    try {
      final cards = await _cardService.getUserCards();
      setState(() => _cards = cards);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _requestNewCard() async {
    final cardType = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Card Type'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Virtual Card'),
              onTap: () => Navigator.pop(context, 'virtual'),
            ),
            ListTile(
              title: const Text('Physical Card'),
              onTap: () => Navigator.pop(context, 'physical'),
            ),
          ],
        ),
      ),
    );

    if (cardType != null) {
      try {
        setState(() => _isLoading = true);
        final result = await _cardService.requestCard(cardType: cardType);

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'] ?? 'Card request submitted')),
        );

        _loadCards(); // Refresh cards list
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  Future<void> _showCardDetails(CardModel card) async {
    try {
      final details = await _cardService.getCardDetails(card.id);
      if (!mounted) return;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Card Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Card Number: ****${details.cardNumber}'),
              const SizedBox(height: 8),
              Text('Expiry Date: ${details.expiryDate.toString().split(' ')[0]}'),
              const SizedBox(height: 8),
              Text('Status: ${details.status}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  Future<void> _blockCard(CardModel card) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Block Card'),
        content: const Text('Are you sure you want to block this card?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Block'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        setState(() => _isLoading = true);
        final result = await _cardService.blockCard(card.id);

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'] ?? 'Card blocked successfully')),
        );

        _loadCards(); // Refresh cards list
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  Future<void> _changePin(CardModel card) async {
    final currentPinController = TextEditingController();
    final newPinController = TextEditingController();

    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change PIN'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: currentPinController,
              decoration: const InputDecoration(labelText: 'Current PIN'),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
              ],
              obscureText: true,
            ),
            TextField(
              controller: newPinController,
              decoration: const InputDecoration(labelText: 'New PIN'),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
              ],
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (currentPinController.text.length == 4 &&
                  newPinController.text.length == 4) {
                Navigator.pop(context, {
                  'currentPin': currentPinController.text,
                  'newPin': newPinController.text,
                });
              }
            },
            child: const Text('Change'),
          ),
        ],
      ),
    );

    if (result != null) {
      try {
        setState(() => _isLoading = false);
        final apiResult = await _cardService.changePin(
          cardId: card.id,
          currentPin: result['currentPin']!,
          newPin: result['newPin']!,
        );

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(apiResult['message'] ?? 'PIN changed successfully')),
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cards'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: _cards.isEmpty
                      ? const Center(
                          child: Text('No cards found'),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16.0),
                          itemCount: _cards.length,
                          itemBuilder: (context, index) {
                            final card = _cards[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 16.0),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Card ****${card.cardNumber}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                        Chip(
                                          label: Text(card.status),
                                          backgroundColor: card.status == 'active'
                                              ? Colors.green[100]
                                              : Colors.red[100],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.visibility),
                                          onPressed: () =>
                                              _showCardDetails(card),
                                          tooltip: 'View Details',
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.block),
                                          onPressed: card.status == 'active'
                                              ? () => _blockCard(card)
                                              : null,
                                          tooltip: 'Block Card',
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.pin),
                                          onPressed: card.status == 'active'
                                              ? () => _changePin(card)
                                              : null,
                                          tooltip: 'Change PIN',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomElevatedButton(
                    onPressed: _requestNewCard,
                    child: const Text('Request New Card'),
                  ),
                ),
              ],
            ),
    );
  }
}
