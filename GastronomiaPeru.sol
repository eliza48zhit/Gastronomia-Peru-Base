// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title GastronomiaPeru
 * @dev Registro historico con Likes, Dislikes e Identificador de Nivel de Picante (1-5).
 */
contract GastronomiaPeru {

    struct Plato {
        string nombre;
        string descripcion;
        uint8 nivelPicante; // Escala del 1 al 5
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public menuHistorico;
    uint256 public totalPlatos;

    constructor() {
        // Inauguramos con el Ceviche Peruano
        registrarPlato(
            "Ceviche Peruano", 
            "Pescado fresco marinado en limon picante, con cebolla roja, camote y choclo.",
            3 // Nivel de picante medio-alto (Aji Limo)
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _descripcion, 
        uint8 _nivelPicante
    ) public {
        require(_nivelPicante >= 1 && _nivelPicante <= 5, "Nivel de picante debe ser entre 1 y 5");
        require(bytes(_nombre).length + bytes(_descripcion).length <= 200, "Texto demasiado largo");
        
        totalPlatos++;
        menuHistorico[totalPlatos] = Plato({
            nombre: _nombre, 
            descripcion: _descripcion,
            nivelPicante: _nivelPicante,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre, 
        string memory descripcion, 
        uint8 nivelPicante,
        uint256 likes, 
        uint256 dislikes
    ) {
        require(_id > 0 && _id <= totalPlatos, "ID invalido.");
        Plato storage p = menuHistorico[_id];
        return (p.nombre, p.descripcion, p.nivelPicante, p.likes, p.dislikes);
    }
}
