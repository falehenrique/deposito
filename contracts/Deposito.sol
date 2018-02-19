pragma solidity 0.4.18;

/*
Simples contrato para demostrar um processo de deposíto(calção) durante um processo de compra
*/
contract Deposito {

    address public comprador;
    address public vendedor;

    Status public statusAtualCompra;
    enum Status {
        PENDENTE,
        AGUARDANDO_ENTREGA,
        FINALIZADO,
        REFUNDED
    }
    
    modifier apenasVendedor() {
        require(msg.sender == vendedor);
        _;
    }    
    
    modifier apenasComprador() {
        require(msg.sender == comprador);
        _;
    }

    modifier statusAtual(Status _statusEsperado) {
        require(statusAtualCompra == _statusEsperado);
        _;
    }
    
    function Deposito(address _comprador, address _vendedor) public {
        require(_comprador != address(0x0) && _vendedor != address(0x0));
        comprador = _comprador;
        vendedor = _vendedor;
    }
    
    function confirmarPagagamento() apenasComprador statusAtual(Status.PENDENTE) payable public {
        statusAtualCompra = Status.AGUARDANDO_ENTREGA;
    }
    
    function confirmarEntrega() apenasVendedor statusAtual(Status.AGUARDANDO_ENTREGA) public {
        vendedor.transfer(this.balance);
        statusAtualCompra = Status.FINALIZADO;
    }
    
    function solicitarRefunded() apenasVendedor statusAtual(Status.AGUARDANDO_ENTREGA) public {
        comprador.transfer(this.balance);
        statusAtualCompra = Status.REFUNDED;
    }
}
