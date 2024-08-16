import Foundation

extension CGFloat {
    /// Convierte el valor a porcentaje truncado a dos decimales y lo devuelve como una cadena
    func toPercentageString() -> String {
        // Multiplica por 100 para convertirlo a porcentaje
        let percentageValue = self * 100
        
        // Trunca el valor a dos decimales sin redondear
        let truncatedValue = percentageValue.truncate(places: 2)
        
        // Devuelve la cadena formateada como porcentaje
        return "\(truncatedValue)%"
    }
}

extension BinaryFloatingPoint {
    /// Trunca el valor a un número especificado de lugares decimales
    func truncate(places: Int) -> Self {
        let divisor = Self(pow(10.0, Double(places)))
        return (self * divisor).rounded(.towardZero) / divisor
    }
}
