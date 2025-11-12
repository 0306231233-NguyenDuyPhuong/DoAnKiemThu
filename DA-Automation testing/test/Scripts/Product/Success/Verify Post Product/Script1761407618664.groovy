import groovy.json.JsonBuilder

def product = [
    title: data.getValue('title', index),  // String
    description: data.getValue('description', index),
    price: data.getValue('price', index).toBigDecimal(),
    discountPercentage: data.getValue('discountPercentage', index).toBigDecimal(),
    rating: data.getValue('rating', index).toBigDecimal(),
    stock: data.getValue('stock', index).toInteger(),
    brand: data.getValue('brand', index),
    category: data.getValue('category', index),
    thumbnail: data.getValue('thumbnail', index),
    images: data.getValue('images', index).split(',') // nếu Excel tách bằng dấu ,
]

def jsonBody = new JsonBuilder(product).toString()
