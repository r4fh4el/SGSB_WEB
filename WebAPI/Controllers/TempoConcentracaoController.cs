using Aplicacao.Interfaces;
using Entidades.Entidades;
using Entidades.Notificacoes;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using WebAPI.Models;

namespace WebAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TempoConcentracaoController : ControllerBase
    {
        private readonly IAplicacaoTempoConcentracao _IAplicacaoTempoConcentracao;

        public TempoConcentracaoController(IAplicacaoTempoConcentracao aplicacaoTempoConcentracao)
        {
            _IAplicacaoTempoConcentracao = aplicacaoTempoConcentracao;
        }

        [AllowAnonymous]
        //[Authorize]
        [Produces("application/json")]
        [HttpGet("/API/ListarTempoConcentracao")]
        public async Task<List<TempoConcentracao>> ListarTempoConcentracao()
        {
            return await _IAplicacaoTempoConcentracao.ListarTempoConcentracao();
        }
        [AllowAnonymous]
        //[Authorize]
        [Produces("application/json")]
        [HttpGet("/API/BuscarPorIdTempoConcentracao")]
        public async Task<TempoConcentracao> BuscarPorIdTempoConcentracao( int id)
        {
            var objTempoConcentracaoModel = await _IAplicacaoTempoConcentracao.BuscarPorId(id);
            return objTempoConcentracaoModel;
        }
        
        [AllowAnonymous]
        //[Authorize]
        [Produces("application/json")]
        [HttpGet("/API/BuscarTempoConcentracaoPorBarragem")]
        public async Task<TempoConcentracao> BuscarTempoConcentracaoPorBarragem(int barragemId)
        {
            var tempos = await _IAplicacaoTempoConcentracao.ListarTempoConcentracao();
            var tempo = tempos.FirstOrDefault(x => x.BarragemId == barragemId);
            return tempo ?? new TempoConcentracao();
        }
        [AllowAnonymous]
        //[Authorize]
        [Produces("application/json")]
        [HttpPost("/API/AdicionarTempoConcentracao")]
        public async Task<List<Notifica>> AdicionarTempoConcentracao( TempoConcentracaoModel tempoConcentracaoModel)
        {
            var objTempoConcentracao = new TempoConcentracao();
            objTempoConcentracao.Id = tempoConcentracaoModel.Id;
            objTempoConcentracao.AreaDrenagem_A = tempoConcentracaoModel.AreaDrenagem_A;
            objTempoConcentracao.ComprimentoRioPrincipal_L = tempoConcentracaoModel.ComprimentoRioPrincipal_L;
            objTempoConcentracao.DeclividadeBacia_S = tempoConcentracaoModel.DeclividadeBacia_S;
            objTempoConcentracao.DataAlteracao = tempoConcentracaoModel.DataAlteracao;
            objTempoConcentracao.DataCadastro = tempoConcentracaoModel.DataCadastro;
            objTempoConcentracao.ResultadoCarter = tempoConcentracaoModel.ResultadoCarter;
            objTempoConcentracao.ResultadoCorpsEngineers = tempoConcentracaoModel.ResultadoCorpsEngineers;
            objTempoConcentracao.ResultadoDooge = tempoConcentracaoModel.ResultadoDooge;
            objTempoConcentracao.ResultadoVenTeChow = tempoConcentracaoModel.ResultadoVenTeChow;
            objTempoConcentracao.ResultadoKirpich = tempoConcentracaoModel.ResultadoKirpich;
            objTempoConcentracao.BarragemId = tempoConcentracaoModel.BarragemId;

            await _IAplicacaoTempoConcentracao.Adicionar(objTempoConcentracao);

            return objTempoConcentracao.Notificacoes;
        }
        [AllowAnonymous]
        //[Authorize]
        [Produces("application/json")]
        [HttpPut("/API/AtualizaTempoConcentracao")]
        public async Task<List<Notifica>> AtualizaTempoConcentracao(TempoConcentracao tempoConcentracaoModel)
        {
            var objTempoConcentracao = await _IAplicacaoTempoConcentracao.BuscarPorId(tempoConcentracaoModel.Id);

            objTempoConcentracao.Id = tempoConcentracaoModel.Id;
            objTempoConcentracao.NomePropriedade = tempoConcentracaoModel.NomePropriedade;
            objTempoConcentracao.AreaDrenagem_A = tempoConcentracaoModel.AreaDrenagem_A;
            objTempoConcentracao.ComprimentoRioPrincipal_L = tempoConcentracaoModel.ComprimentoRioPrincipal_L;
            objTempoConcentracao.DeclividadeBacia_S = tempoConcentracaoModel.DeclividadeBacia_S;
            objTempoConcentracao.DataAlteracao = tempoConcentracaoModel.DataAlteracao;
            objTempoConcentracao.DataCadastro = tempoConcentracaoModel.DataCadastro;
            objTempoConcentracao.ResultadoCarter = tempoConcentracaoModel.ResultadoCarter;
            objTempoConcentracao.ResultadoCorpsEngineers = tempoConcentracaoModel.ResultadoCorpsEngineers;
            objTempoConcentracao.ResultadoDooge = tempoConcentracaoModel.ResultadoDooge;
            objTempoConcentracao.ResultadoVenTeChow = tempoConcentracaoModel.ResultadoVenTeChow;
            objTempoConcentracao.ResultadoKirpich = tempoConcentracaoModel.ResultadoKirpich;
            objTempoConcentracao.BarragemId = tempoConcentracaoModel.BarragemId;

            objTempoConcentracao.DataAlteracao = DateTime.Now;

            await _IAplicacaoTempoConcentracao.Atualizar(objTempoConcentracao);

            return objTempoConcentracao.Notificacoes;
        }

        [AllowAnonymous]
        //[Authorize]
        [Produces("application/json")]
        [HttpPost("/API/ExcluirTempoConcentracao")]
        public async Task<List<Notifica>> ExcluirTempoConcentracao(TempoConcentracao tempoConcentracaoModel)
        {
            var objTempoConcentracaoModel = await _IAplicacaoTempoConcentracao.BuscarPorId(tempoConcentracaoModel.Id);

            await _IAplicacaoTempoConcentracao.Excluir(objTempoConcentracaoModel);

            return objTempoConcentracaoModel.Notificacoes;
        }

  
        /// <summary>
        /// Calcula automaticamente o tempo de concentração para uma barragem
        /// </summary>
        [AllowAnonymous]
        [Produces("application/json")]
        [HttpPost("/API/CalcularTempoConcentracaoAutomatico")]
        public async Task<IActionResult> CalcularTempoConcentracaoAutomatico([FromBody] CalcularTempoConcentracaoRequest request)
        {
            try
            {
                // Buscar tempo de concentração existente para a barragem
                var tempos = await _IAplicacaoTempoConcentracao.ListarTempoConcentracao();
                var tempoExistente = tempos.FirstOrDefault(x => x.BarragemId == request.BarragemId);

                if (tempoExistente == null)
                {
                    return NotFound(new { message = "Tempo de concentração não encontrado para esta barragem. Certifique-se de que os dados foram sincronizados primeiro." });
                }

                // Calcular todas as equações
                // Kirpich (1940)
                if (tempoExistente.ComprimentoRioPrincipal_L > 0 && tempoExistente.DeclividadeBacia_S > 0)
                {
                    tempoExistente.ResultadoKirpich = 0.0663 * Math.Pow(tempoExistente.ComprimentoRioPrincipal_L, 0.77) * Math.Pow(tempoExistente.DeclividadeBacia_S, -0.385);
                }

                // Corps Engineers (1946)
                if (tempoExistente.ComprimentoRioPrincipal_L > 0 && tempoExistente.DeclividadeBacia_S > 0)
                {
                    tempoExistente.ResultadoCorpsEngineers = 0.191 * Math.Pow(tempoExistente.ComprimentoRioPrincipal_L, 0.76) * Math.Pow(tempoExistente.DeclividadeBacia_S, -0.19);
                }

                // Carter (1961)
                if (tempoExistente.ComprimentoRioPrincipal_L > 0 && tempoExistente.DeclividadeBacia_S > 0)
                {
                    tempoExistente.ResultadoCarter = 0.0977 * Math.Pow(tempoExistente.ComprimentoRioPrincipal_L, 0.6) * Math.Pow(tempoExistente.DeclividadeBacia_S, -0.3);
                }

                // Dooge (1956)
                if (tempoExistente.AreaDrenagem_A > 0 && tempoExistente.DeclividadeBacia_S > 0)
                {
                    tempoExistente.ResultadoDooge = 0.365 * Math.Pow(tempoExistente.AreaDrenagem_A, 0.41) * Math.Pow(tempoExistente.DeclividadeBacia_S, -0.17);
                }

                // Ven te Chow (1962)
                if (tempoExistente.ComprimentoRioPrincipal_L > 0 && tempoExistente.DeclividadeBacia_S > 0)
                {
                    var L = double.Parse(tempoExistente.ComprimentoRioPrincipal_L.ToString().Replace(",", "."));
                    var S = double.Parse(tempoExistente.DeclividadeBacia_S.ToString().Replace(",", "."));
                    tempoExistente.ResultadoVenTeChow = 0.160 * Math.Pow(L, 0.64) * Math.Pow(S, -0.32);
                }

                // Atualizar no banco
                tempoExistente.DataAlteracao = DateTime.Now;
                await _IAplicacaoTempoConcentracao.Atualizar(tempoExistente);

                return Ok(new
                {
                    success = true,
                    message = "Cálculos de tempo de concentração executados com sucesso",
                    barragemId = request.BarragemId,
                    resultados = new
                    {
                        kirpich = tempoExistente.ResultadoKirpich,
                        corpsEngineers = tempoExistente.ResultadoCorpsEngineers,
                        carter = tempoExistente.ResultadoCarter,
                        dooge = tempoExistente.ResultadoDooge,
                        venTeChow = tempoExistente.ResultadoVenTeChow
                    }
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = ex.Message });
            }
        }

        private async Task<string> RetornarIdUsuarioLogado()
        {
            if (User != null)
            {
                var idUsuario = User.FindFirst("idUsuario");
                return idUsuario.Value;
            }
            else 
            {
                return string.Empty;
            }
        }
    }

    public class CalcularTempoConcentracaoRequest
    {
        public int BarragemId { get; set; }
    }
}
