# Pseudo-JSON

Pseudo-JSON is a simple API integration project that fetches product data from [DummyJSON](https://dummyjson.com/docs/products). It allows users to retrieve all products, search for specific products, and sort results by title in ascending or descending order.

## Features

- **Get All Products**: Fetch and display a list of all available products.
- **Search Products**: Find specific products by entering a search query.
- **Sorting**: Sort products by title in ascending or descending order.

## API Endpoints Used

- **Get all products**: `https://dummyjson.com/products`
- **Search products**: `https://dummyjson.com/products/search?q={query}`
- **Sorting**:
  - **Ascending**: `https://dummyjson.com/products?sortBy=title&order=asc`
  - **Descending**: `https://dummyjson.com/products?sortBy=title&order=desc`
