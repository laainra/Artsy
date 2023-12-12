class ShippingInfo {
  final String? fullName;
  final String? country;
  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? phoneNumber;
  final bool? saveAddressForLaterUse;

  ShippingInfo({
    this.fullName,
    this.country,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.postalCode,
    this.phoneNumber,
    this.saveAddressForLaterUse,
  });
}
