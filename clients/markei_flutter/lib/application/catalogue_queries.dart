import '../domain/catalogue/product.dart';
import '../domain/shared/ids.dart';
import '../domain/store/store.dart';

abstract interface class CatalogueQueryRepository {
  Future<List<Product>> listProducts(AccountId accountId);

  Future<List<Store>> listStores(AccountId accountId);

  Future<List<ProductSimilarityWarning>> similarityWarnings(
    AccountId accountId,
    ProductDraft draft,
  );
}

final class ProductSimilarityWarning {
  const ProductSimilarityWarning({
    required this.existingProduct,
    required this.draftFacts,
  });

  final Product existingProduct;
  final NormalizedProductFacts draftFacts;
}
