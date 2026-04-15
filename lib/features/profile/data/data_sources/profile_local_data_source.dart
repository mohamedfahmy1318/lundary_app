import 'package:laundry/core/error/exceptions.dart';
import 'package:laundry/features/profile/data/models/profile_model.dart';
import 'package:laundry/features/profile/data/models/ticket_model.dart';

abstract class ProfileLocalDataSource {
  Future<void> cacheProfile(ProfileModel profile);
  Future<ProfileModel> getCachedProfile();

  Future<void> cacheTickets(List<TicketModel> tickets);
  Future<List<TicketModel>> getCachedTickets();

  Future<void> cacheTicket(TicketModel ticket);
  Future<TicketModel> getCachedTicketDetails(int ticketId);

  Future<void> cacheTicketCategories(List<TicketLookupOptionModel> categories);
  Future<List<TicketLookupOptionModel>> getCachedTicketCategories();

  Future<void> cacheTicketPriorities(List<TicketLookupOptionModel> priorities);
  Future<List<TicketLookupOptionModel>> getCachedTicketPriorities();

  Future<void> cacheTicketStatuses(List<TicketLookupOptionModel> statuses);
  Future<List<TicketLookupOptionModel>> getCachedTicketStatuses();

  Future<void> cacheSubscriptionPlans(List<SubscriptionPlanModel> plans);
  Future<List<SubscriptionPlanModel>> getCachedSubscriptionPlans();

  Future<void> cacheMySubscriptions(
    List<ActiveSubscriptionModel> mySubscriptions,
  );
  Future<List<ActiveSubscriptionModel>> getCachedMySubscriptions();
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  ProfileModel? _cachedProfile;

  List<TicketModel> _cachedTickets = const <TicketModel>[];
  final Map<int, TicketModel> _cachedTicketsById = <int, TicketModel>{};

  List<TicketLookupOptionModel> _cachedTicketCategories =
      const <TicketLookupOptionModel>[];
  List<TicketLookupOptionModel> _cachedTicketPriorities =
      const <TicketLookupOptionModel>[];
  List<TicketLookupOptionModel> _cachedTicketStatuses =
      const <TicketLookupOptionModel>[];

  List<SubscriptionPlanModel> _cachedSubscriptionPlans =
      const <SubscriptionPlanModel>[];
  List<ActiveSubscriptionModel> _cachedMySubscriptions =
      const <ActiveSubscriptionModel>[];

  @override
  Future<void> cacheProfile(ProfileModel profile) async {
    _cachedProfile = profile;
  }

  @override
  Future<ProfileModel> getCachedProfile() async {
    final cached = _cachedProfile;
    if (cached == null) {
      throw const CacheException(message: 'No cached profile found.');
    }
    return cached;
  }

  @override
  Future<void> cacheTickets(List<TicketModel> tickets) async {
    _cachedTickets = List<TicketModel>.unmodifiable(tickets);
    _cachedTicketsById
      ..clear()
      ..addEntries(tickets.map((ticket) => MapEntry(ticket.id, ticket)));
  }

  @override
  Future<List<TicketModel>> getCachedTickets() async {
    if (_cachedTickets.isEmpty) {
      throw const CacheException(message: 'No cached tickets found.');
    }
    return _cachedTickets;
  }

  @override
  Future<void> cacheTicket(TicketModel ticket) async {
    _cachedTicketsById[ticket.id] = ticket;

    final existingIndex = _cachedTickets.indexWhere((t) => t.id == ticket.id);
    if (existingIndex == -1) {
      _cachedTickets = List<TicketModel>.unmodifiable(<TicketModel>[
        ticket,
        ..._cachedTickets,
      ]);
      return;
    }

    final updated = List<TicketModel>.from(_cachedTickets);
    updated[existingIndex] = ticket;
    _cachedTickets = List<TicketModel>.unmodifiable(updated);
  }

  @override
  Future<TicketModel> getCachedTicketDetails(int ticketId) async {
    final cached = _cachedTicketsById[ticketId];
    if (cached == null) {
      throw const CacheException(message: 'No cached ticket details found.');
    }
    return cached;
  }

  @override
  Future<void> cacheTicketCategories(
    List<TicketLookupOptionModel> categories,
  ) async {
    _cachedTicketCategories = List<TicketLookupOptionModel>.unmodifiable(
      categories,
    );
  }

  @override
  Future<List<TicketLookupOptionModel>> getCachedTicketCategories() async {
    if (_cachedTicketCategories.isEmpty) {
      throw const CacheException(message: 'No cached ticket categories found.');
    }
    return _cachedTicketCategories;
  }

  @override
  Future<void> cacheTicketPriorities(
    List<TicketLookupOptionModel> priorities,
  ) async {
    _cachedTicketPriorities = List<TicketLookupOptionModel>.unmodifiable(
      priorities,
    );
  }

  @override
  Future<List<TicketLookupOptionModel>> getCachedTicketPriorities() async {
    if (_cachedTicketPriorities.isEmpty) {
      throw const CacheException(message: 'No cached ticket priorities found.');
    }
    return _cachedTicketPriorities;
  }

  @override
  Future<void> cacheTicketStatuses(
    List<TicketLookupOptionModel> statuses,
  ) async {
    _cachedTicketStatuses = List<TicketLookupOptionModel>.unmodifiable(
      statuses,
    );
  }

  @override
  Future<List<TicketLookupOptionModel>> getCachedTicketStatuses() async {
    if (_cachedTicketStatuses.isEmpty) {
      throw const CacheException(message: 'No cached ticket statuses found.');
    }
    return _cachedTicketStatuses;
  }

  @override
  Future<void> cacheSubscriptionPlans(List<SubscriptionPlanModel> plans) async {
    _cachedSubscriptionPlans = List<SubscriptionPlanModel>.unmodifiable(plans);
  }

  @override
  Future<List<SubscriptionPlanModel>> getCachedSubscriptionPlans() async {
    if (_cachedSubscriptionPlans.isEmpty) {
      throw const CacheException(
        message: 'No cached subscription plans found.',
      );
    }
    return _cachedSubscriptionPlans;
  }

  @override
  Future<void> cacheMySubscriptions(
    List<ActiveSubscriptionModel> mySubscriptions,
  ) async {
    _cachedMySubscriptions = List<ActiveSubscriptionModel>.unmodifiable(
      mySubscriptions,
    );
  }

  @override
  Future<List<ActiveSubscriptionModel>> getCachedMySubscriptions() async {
    if (_cachedMySubscriptions.isEmpty) {
      throw const CacheException(
        message: 'No cached user subscriptions found.',
      );
    }
    return _cachedMySubscriptions;
  }
}
