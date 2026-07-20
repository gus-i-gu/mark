import '../domain/catalogue/product.dart';
import '../domain/shared/ids.dart';
import '../domain/store/store.dart';

abstract interface class CatalogueQueryRepository {
  Future<List<Product>> listProducts(AccountId accountId);

  Future<Product?> productByCode(AccountId accountId, String productCode);

  Future<Product?> productByExactIdentity(
    AccountId accountId,
    ProductDraft draft,
  );

  Future<Product?> productDetail(AccountId accountId, ProductId productId);

  Future<List<Store>> listStores(AccountId accountId);

  Future<Store> createStore(AccountId accountId, String displayName);

  Future<Product> createProduct(AccountId accountId, ProductDraft draft);

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
