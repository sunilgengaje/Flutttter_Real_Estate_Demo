import 'package:flutter/material.dart';

enum OrderStatus {
  placed,
  confirmed,
  loading,
  inTransit,
  arrivedOnSite,
  delivered,
  settled
}

class MaterialItem {
  final String id;
  final String name;
  final String category;
  final IconData icon;
  final String defaultUnit;
  final double defaultPricePerUnit;

  const MaterialItem({
    required this.id,
    required this.name,
    required this.category,
    required this.icon,
    required this.defaultUnit,
    required this.defaultPricePerUnit,
  });
}

class SupplierBid {
  final String id;
  final String supplierName;
  final String supplierLogo;
  final double rating;
  final int ratingCount;
  final double distanceKm;
  final double pricePerUnit;
  final double transportFare;
  final double gstAmount;
  final double totalPrice;
  final String etaText;
  final int etaMinutes;
  final int aiMatchScore; // e.g., 96
  final String aiReason; // e.g., "₹1,200 lower than avg • 45 min ETA • 4.9★"
  final bool isAiTopMatch;
  final bool isLowestPrice;
  final bool isFastestEta;
  final bool isHighestRated;

  const SupplierBid({
    required this.id,
    required this.supplierName,
    required this.supplierLogo,
    required this.rating,
    required this.ratingCount,
    required this.distanceKm,
    required this.pricePerUnit,
    required this.transportFare,
    required this.gstAmount,
    required this.totalPrice,
    required this.etaText,
    required this.etaMinutes,
    required this.aiMatchScore,
    required this.aiReason,
    this.isAiTopMatch = false,
    this.isLowestPrice = false,
    this.isFastestEta = false,
    this.isHighestRated = false,
  });
}

class DispatchInfo {
  final String vehicleType; // e.g., "Mini Truck (Tata Ace)", "16-Ton Tipper"
  final String vehicleRegNumber; // e.g., "MH12AB1234"
  final String driverName; // e.g., "Rajesh Kumar"
  final String driverPhone; // e.g., "+91 98765 00000"
  final int loaderCrewCount; // e.g., 3
  final List<String> proofImageUrls; // weighbridge slip, loaded truck photos

  const DispatchInfo({
    required this.vehicleType,
    required this.vehicleRegNumber,
    required this.driverName,
    required this.driverPhone,
    required this.loaderCrewCount,
    required this.proofImageUrls,
  });
}

class DeliveryTrip {
  final String id;
  final String materialName;
  final int quantity;
  final String unit;
  final String pickupAddress;
  final String dropAddress;
  final SupplierBid selectedBid;
  final DispatchInfo dispatchInfo;
  final String deliveryOtp; // e.g., "4829"
  OrderStatus status;

  DeliveryTrip({
    required this.id,
    required this.materialName,
    required this.quantity,
    required this.unit,
    required this.pickupAddress,
    required this.dropAddress,
    required this.selectedBid,
    required this.dispatchInfo,
    required this.deliveryOtp,
    this.status = OrderStatus.placed,
  });
}
