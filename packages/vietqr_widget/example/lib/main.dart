import 'package:flutter/material.dart';
import 'package:vietqr_widget/vietqr_widget.dart';

void main() {
  runApp(const VietQrExampleApp());
}

class VietQrExampleApp extends StatelessWidget {
  const VietQrExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VietQR Widget Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const VietQrExampleScreen(),
    );
  }
}

class VietQrExampleScreen extends StatefulWidget {
  const VietQrExampleScreen({super.key});

  @override
  State<VietQrExampleScreen> createState() => _VietQrExampleScreenState();
}

class _VietQrExampleScreenState extends State<VietQrExampleScreen> {
  VietQrData _currentQrData = VietQrData(
    bankBinCode: SupportedBank.vietcombank,
    bankAccount: 'v9x',
    merchantName: 'VietQR Widget',
    merchantCity: 'Hanoi',
    additional: const AdditionalData(purpose: 'Coffee payment'),
  );

  void _onQrGenerated(VietQrData qrData) {
    setState(() {
      _currentQrData = qrData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1024),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 640;
          final safePadding = MediaQuery.of(context).padding;

          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              centerTitle: true,
              title: const Text('VietQR Widget Example'),
            ),
            floatingActionButton: isMobile
                ? FloatingActionButton(
                    onPressed: () => showSettingsBottomSheet(
                      context,
                      initialData: _currentQrData,
                      onQrGenerated: _onQrGenerated,
                    ),
                    child: const Icon(Icons.qr_code),
                  )
                : null,
            body: Align(
              alignment: Alignment.topCenter,
              child: isMobile
                  ? Padding(
                      padding: safePadding.copyWith(top: 0, bottom: 0),
                      child: _AnimatedVietQrWidget(qrData: _currentQrData),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: safePadding.left + 24,
                              right: safePadding.right + 24,
                              bottom: 24,
                            ),
                            child: _AnimatedVietQrWidget(
                              qrData: _currentQrData,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: SingleChildScrollView(
                            padding: safePadding.copyWith(top: 0),
                            child: _VietQrSettings(
                              initialData: _currentQrData,
                              onQrGenerated: _onQrGenerated,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}

class _AnimatedVietQrWidget extends StatefulWidget {
  final VietQrData qrData;

  const _AnimatedVietQrWidget({required this.qrData});

  @override
  State<_AnimatedVietQrWidget> createState() => _AnimatedVietQrWidgetState();
}

class _AnimatedVietQrWidgetState extends State<_AnimatedVietQrWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  VietQrData? _previousQrData;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _animationController.forward();
    _previousQrData = widget.qrData;
  }

  @override
  void didUpdateWidget(_AnimatedVietQrWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.qrData != _previousQrData) {
      _animationController.reset();
      _animationController.forward();
      _previousQrData = widget.qrData;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  width: 280,
                  height: 280,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: VietQrWidget(
                    data: widget.qrData,
                    embeddedImage: EmbeddedImage(
                      scale: 0.2,
                      image: AssetImage("assets/flutter.png"),
                    ),
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Text(
                          error.toString(),
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.red,
                                  ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
          Text(
            'QR Code for ${widget.qrData.merchantName.isNotEmpty ? widget.qrData.merchantName : "Payment"}',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class _VietQrSettings extends StatefulWidget {
  final VietQrData initialData;
  final ValueChanged<VietQrData> onQrGenerated;

  const _VietQrSettings({
    required this.initialData,
    required this.onQrGenerated,
  });

  @override
  State<_VietQrSettings> createState() => _VietQrSettingsState();
}

class _VietQrSettingsState extends State<_VietQrSettings> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _merchantNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  SupportedBank _selectedBank = SupportedBank.vietcombank;

  @override
  void initState() {
    setValues();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _VietQrSettings oldWidget) {
    if (oldWidget.initialData != widget.initialData) {
      setValues();
    }
    super.didUpdateWidget(oldWidget);
  }

  void setValues() {
    _amountController.text = widget.initialData.amount;
    _accountController.text =
        widget.initialData.merchantAccInfo.beneficiaryOrgData.bankAccount;
    _merchantNameController.text = widget.initialData.merchantName;
    _descriptionController.text = widget.initialData.additional.purpose;
    _selectedBank = SupportedBank.fromBinCode(
          widget.initialData.merchantAccInfo.beneficiaryOrgData.bankBinCode,
        ) ??
        SupportedBank.vietcombank;
  }

  void _generateQrCode() {
    if (_accountController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter bank account number')),
      );
      return;
    }

    final qrData = VietQrData(
      bankBinCode: _selectedBank,
      bankAccount: _accountController.text.trim(),
      amount: _amountController.text.trim().isNotEmpty
          ? _amountController.text.trim()
          : null,
      merchantName: _merchantNameController.text.trim().isNotEmpty
          ? _merchantNameController.text.trim()
          : null,
      additional: _descriptionController.text.trim().isNotEmpty
          ? AdditionalData(purpose: _descriptionController.text.trim())
          : null,
    );

    widget.onQrGenerated(qrData);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'QR Configuration',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 24),
          _buildSection(
            context,
            title: 'Bank Information',
            icon: Icons.account_balance,
            children: [
              DropdownButtonFormField<SupportedBank>(
                value: _selectedBank,
                decoration: const InputDecoration(
                  labelText: 'Select Bank',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.account_balance),
                ),
                items: SupportedBank.values.map((bank) {
                  return DropdownMenuItem(
                    value: bank,
                    child: Text(bank.name),
                  );
                }).toList(),
                onChanged: (bank) {
                  if (bank == null) return;
                  _selectedBank = bank;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _accountController,
                label: 'Bank Account Number',
                icon: Icons.credit_card,
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            context,
            title: 'Payment Details',
            icon: Icons.payment,
            children: [
              _buildTextField(
                controller: _amountController,
                label: 'Amount (VND)',
                icon: Icons.attach_money,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _merchantNameController,
                label: 'Merchant Name',
                icon: Icons.store,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _descriptionController,
                label: 'Payment Description',
                icon: Icons.description,
                maxLines: 2,
              ),
            ],
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: _generateQrCode,
            icon: const Icon(Icons.qr_code),
            label: const Text('Generate QR Code'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: Theme.of(context).primaryColor),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  TextField _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icon),
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _accountController.dispose();
    _merchantNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}

void showSettingsBottomSheet(
  BuildContext context, {
  required VietQrData initialData,
  required ValueChanged<VietQrData> onQrGenerated,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
      return DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.75,
        maxChildSize: 0.8,
        expand: false,
        builder: (context, scrollController) {
          return Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: SingleChildScrollView(
              controller: scrollController,
              child: _VietQrSettings(
                initialData: initialData,
                onQrGenerated: (qrData) {
                  Navigator.pop(context);
                  onQrGenerated(qrData);
                },
              ),
            ),
          );
        },
      );
    },
  );
}
