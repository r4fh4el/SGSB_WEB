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
    public class IndiceCaracterizacaoBHController : ControllerBase
    {
        private readonly IAplicacaoIndiceCaracterizacaoBH _IAplicacaoIndiceCaracterizacaoBH;
        private readonly IAplicacaoTempoConcentracao _IAplicacaoTempoConcentracao;

        public IndiceCaracterizacaoBHController(
            IAplicacaoIndiceCaracterizacaoBH aplicacaoIndiceCaracterizacaoBH,
            IAplicacaoTempoConcentracao aplicacaoTempoConcentracao)
        {
            _IAplicacaoIndiceCaracterizacaoBH = aplicacaoIndiceCaracterizacaoBH;
            _IAplicacaoTempoConcentracao = aplicacaoTempoConcentracao;
        }

        [AllowAnonymous]
        //[Authorize]
        [Produces("application/json")]
        [HttpGet("/API/ListarIndiceCaracterizacaoBH")]
        public async Task<List<IndiceCaracterizacaoBH>> ListarIndiceCaracterizacaoBH()
        {
            return await _IAplicacaoIndiceCaracterizacaoBH.ListarIndiceCaracterizacaoBH();
        }
        [AllowAnonymous]
        //[Authorize]
        [Produces("application/json")]
        [HttpGet("/API/BuscarPorIdIndiceCaracterizacaoBH")]
        public async Task<IndiceCaracterizacaoBH> BuscarPorIdIndiceCaracterizacaoBH( int id)
        {
            var objIndiceCaracterizacaoBHModel = await _IAplicacaoIndiceCaracterizacaoBH.BuscarPorId(id);
            return objIndiceCaracterizacaoBHModel;
        }
        
        [AllowAnonymous]
        //[Authorize]
        [Produces("application/json")]
        [HttpGet("/API/BuscarIndiceCaracterizacaoBHPorBarragem")]
        public async Task<IndiceCaracterizacaoBH> BuscarIndiceCaracterizacaoBHPorBarragem(int barragemId)
        {
            var indices = await _IAplicacaoIndiceCaracterizacaoBH.ListarIndiceCaracterizacaoBH();
            var indice = indices.FirstOrDefault(x => x.Barragem_ID == barragemId);
            return indice ?? new IndiceCaracterizacaoBH();
        }
        [AllowAnonymous]
        //[Authorize]
        [Produces("application/json")]
        [HttpPost("/API/AdicionarIndiceCaracterizacaoBH")]
        public async Task<List<Notifica>> AdicionarIndiceCaracterizacaoBH(IndiceCaracterizacaoBHModel indiceCaracterizacaoBHModel)
        {
            var objIndiceCaracterizacaoBHModel = new IndiceCaracterizacaoBH()
            {
                Id = indiceCaracterizacaoBHModel.Id,
                AltitudeAltimetricaBaciaKM = indiceCaracterizacaoBHModel.AltitudeAltimetricaBaciaKM,
                AltitudeAltimetricaBaciaM = indiceCaracterizacaoBHModel.AltitudeAltimetricaBaciaM,
                AltitudeMaximaBacia = indiceCaracterizacaoBHModel.AltitudeMaximaBacia,
                AltitudeMinimaBacia = indiceCaracterizacaoBHModel.AltitudeMinimaBacia,
                AreaBaciaHidrografica = indiceCaracterizacaoBHModel.AreaBaciaHidrografica,
                Barragem_ID = indiceCaracterizacaoBHModel.Barragem_ID,
                ComprimentoAxialBacia = indiceCaracterizacaoBHModel.ComprimentoAxialBacia,
                ComprimentoRioPrincipal = indiceCaracterizacaoBHModel.ComprimentoRioPrincipal,
                ComprimentoVetorialRioPrincipal = indiceCaracterizacaoBHModel.ComprimentoVetorialRioPrincipal,
                ComprimentoTotalRioBacia = indiceCaracterizacaoBHModel.ComprimentoTotalRioBacia,
                Perimetro = indiceCaracterizacaoBHModel.Perimetro,
                ResultadoCoeficienteCompacidade = indiceCaracterizacaoBHModel.ResultadoCoeficienteCompacidade,
                ResultadoCoeficienteManutencao = indiceCaracterizacaoBHModel.ResultadoCoeficienteManutencao,
                ResultadoDensidadeDrenagem = indiceCaracterizacaoBHModel.ResultadoDensidadeDrenagem,
                ResultadoFatorForma = indiceCaracterizacaoBHModel.ResultadoFatorForma,
                ResultadoGradienteCanais = indiceCaracterizacaoBHModel.ResultadoGradienteCanais,
                ResultadoIndiceCircularidade = indiceCaracterizacaoBHModel.ResultadoIndiceCircularidade,
                ResultadoIndiceRugosidade = indiceCaracterizacaoBHModel.ResultadoIndiceRugosidade,
                ResultadoRelacaoRelevo = indiceCaracterizacaoBHModel.ResultadoRelacaoRelevo,
                ResultadoSinuosidadeCursoDagua = indiceCaracterizacaoBHModel.ResultadoSinuosidadeCursoDagua,
                AltitudeVetorialRioPrincipal = indiceCaracterizacaoBHModel.AltitudeVetorialRioPrincipal
            };

             await _IAplicacaoIndiceCaracterizacaoBH.Adicionar(objIndiceCaracterizacaoBHModel);

            // Calcular automaticamente após adicionar
            await CalcularIndicesAutomaticamente(objIndiceCaracterizacaoBHModel);

            return objIndiceCaracterizacaoBHModel.Notificacoes;
        }
        [AllowAnonymous]
        //[Authorize]
        [Produces("application/json")]
        [HttpPut("/API/AtualizaIndiceCaracterizacaoBH")]
        public async Task<List<Notifica>> AtualizaIndiceCaracterizacaoBH(IndiceCaracterizacaoBHModel indiceCaracterizacaoBHModel)
        {
            var objIndiceCaracterizacaoBH = await _IAplicacaoIndiceCaracterizacaoBH.BuscarPorId(indiceCaracterizacaoBHModel.Id);

            objIndiceCaracterizacaoBH.Id = indiceCaracterizacaoBHModel.Id;
                objIndiceCaracterizacaoBH.AltitudeAltimetricaBaciaKM = indiceCaracterizacaoBHModel.AltitudeAltimetricaBaciaKM;
                objIndiceCaracterizacaoBH.AltitudeAltimetricaBaciaM = indiceCaracterizacaoBHModel.AltitudeAltimetricaBaciaM;
                objIndiceCaracterizacaoBH.AltitudeMaximaBacia = indiceCaracterizacaoBHModel.AltitudeMaximaBacia;
                objIndiceCaracterizacaoBH.AltitudeMinimaBacia = indiceCaracterizacaoBHModel.AltitudeMinimaBacia;
                objIndiceCaracterizacaoBH.AreaBaciaHidrografica = indiceCaracterizacaoBHModel.AreaBaciaHidrografica;
                objIndiceCaracterizacaoBH.Barragem_ID = indiceCaracterizacaoBHModel.Barragem_ID;
                objIndiceCaracterizacaoBH.ComprimentoAxialBacia = indiceCaracterizacaoBHModel.ComprimentoAxialBacia;
                objIndiceCaracterizacaoBH.ComprimentoRioPrincipal = indiceCaracterizacaoBHModel.ComprimentoRioPrincipal;
                objIndiceCaracterizacaoBH.ComprimentoVetorialRioPrincipal = indiceCaracterizacaoBHModel.ComprimentoVetorialRioPrincipal;
                objIndiceCaracterizacaoBH.ComprimentoTotalRioBacia = indiceCaracterizacaoBHModel.ComprimentoTotalRioBacia;

                objIndiceCaracterizacaoBH.Perimetro = indiceCaracterizacaoBHModel.Perimetro;
                objIndiceCaracterizacaoBH.ResultadoCoeficienteCompacidade = indiceCaracterizacaoBHModel.ResultadoCoeficienteCompacidade;
                objIndiceCaracterizacaoBH.ResultadoCoeficienteManutencao = indiceCaracterizacaoBHModel.ResultadoCoeficienteManutencao;
                objIndiceCaracterizacaoBH.ResultadoDensidadeDrenagem = indiceCaracterizacaoBHModel.ResultadoDensidadeDrenagem;
                objIndiceCaracterizacaoBH.ResultadoFatorForma = indiceCaracterizacaoBHModel.ResultadoFatorForma;
                objIndiceCaracterizacaoBH.ResultadoGradienteCanais = indiceCaracterizacaoBHModel.ResultadoGradienteCanais;
                objIndiceCaracterizacaoBH.ResultadoIndiceCircularidade = indiceCaracterizacaoBHModel.ResultadoIndiceCircularidade;
                objIndiceCaracterizacaoBH.ResultadoIndiceRugosidade = indiceCaracterizacaoBHModel.ResultadoIndiceRugosidade;
                objIndiceCaracterizacaoBH.ResultadoRelacaoRelevo = indiceCaracterizacaoBHModel.ResultadoRelacaoRelevo;
                objIndiceCaracterizacaoBH.ResultadoSinuosidadeCursoDagua = indiceCaracterizacaoBHModel.ResultadoSinuosidadeCursoDagua;
            objIndiceCaracterizacaoBH.AltitudeVetorialRioPrincipal = indiceCaracterizacaoBHModel.AltitudeVetorialRioPrincipal;

            await _IAplicacaoIndiceCaracterizacaoBH.Atualizar(objIndiceCaracterizacaoBH);

            // Calcular automaticamente após atualizar
            await CalcularIndicesAutomaticamente(objIndiceCaracterizacaoBH);

            return objIndiceCaracterizacaoBH.Notificacoes;
        }

        [AllowAnonymous]
        //[Authorize]
        [Produces("application/json")]
        [HttpPost("/API/ExcluirIndiceCaracterizacaoBH")]
        public async Task<List<Notifica>> ExcluirIndiceCaracterizacaoBH(IndiceCaracterizacaoBH indiceCaracterizacaoBHModel)
        {
            var objIndiceCaracterizacaoBHModel = await _IAplicacaoIndiceCaracterizacaoBH.BuscarPorId(indiceCaracterizacaoBHModel.Id);

            await _IAplicacaoIndiceCaracterizacaoBH.Excluir(objIndiceCaracterizacaoBHModel);

            return objIndiceCaracterizacaoBHModel.Notificacoes;
        }

  
        /// <summary>
        /// Método privado para calcular índices automaticamente
        /// </summary>
        private async Task CalcularIndicesAutomaticamente(IndiceCaracterizacaoBH indice)
        {
            try
            {
                // Validar valores antes de calcular
                if (indice.Perimetro <= 0 || indice.AreaBaciaHidrografica <= 0)
                {
                    return; // Não calcular se dados inválidos
                }

                // Índice de circularidade (Ic) - Miller (1953)
                indice.ResultadoIndiceCircularidade = 12.57 * (indice.AreaBaciaHidrografica / Math.Pow(indice.Perimetro, 2));

                // Fator de forma (F) - Horton (1945)
                if (indice.ComprimentoAxialBacia > 0)
                {
                    indice.ResultadoFatorForma = indice.Perimetro / Math.Pow(indice.ComprimentoAxialBacia, 2);
                }

                // Coeficiente de compacidade (Kc) - Lima (1969)
                indice.ResultadoCoeficienteCompacidade = 0.28 * (indice.Perimetro / Math.Sqrt(indice.AreaBaciaHidrografica));

                // Densidade de drenagem (Dd) - Horton (1945)
                if (indice.AreaBaciaHidrografica > 0)
                {
                    indice.ResultadoDensidadeDrenagem = indice.ComprimentoTotalRioBacia / indice.AreaBaciaHidrografica;

                    // Coeficiente de manutenção (Cm)
                    if (indice.ResultadoDensidadeDrenagem > 0)
                    {
                        indice.ResultadoCoeficienteManutencao = 1 / indice.ResultadoDensidadeDrenagem;
                    }
                }

                // Gradiente de canais (Gc)
                if (indice.ComprimentoRioPrincipal > 0)
                {
                    indice.ResultadoGradienteCanais = (indice.AltitudeAltimetricaBaciaM / (indice.ComprimentoRioPrincipal * 1000)) * 100;

                    // Relação de relevo (Rr) - Christofoletti (1969)
                    indice.ResultadoRelacaoRelevo = indice.AltitudeAltimetricaBaciaM / indice.ComprimentoRioPrincipal;
                }

                // Índice de rugosidade (IR) - Christofoletti (1969)
                indice.ResultadoIndiceRugosidade = indice.AltitudeAltimetricaBaciaM / 1000;

                // Sinuosidade do curso d'água principal (S) - Schumm (1963)
                if (indice.ComprimentoVetorialRioPrincipal > 0 && indice.ComprimentoRioPrincipal > 0)
                {
                    indice.ResultadoSinuosidadeCursoDagua = indice.ComprimentoRioPrincipal / indice.ComprimentoVetorialRioPrincipal;
                }

                // Atualizar data de alteração
                indice.DataAlteracao = DateTime.Now;

                // Salvar novamente com os resultados calculados
                await _IAplicacaoIndiceCaracterizacaoBH.Atualizar(indice);
            }
            catch (Exception ex)
            {
                // Log erro mas não quebra o fluxo
                Console.WriteLine($"[CalcularIndicesAutomaticamente] Erro: {ex.Message}");
            }
        }

        /// <summary>
        /// Calcula automaticamente todos os índices de caracterização para uma barragem
        /// Recebe dados do SGSB_INSP e calcula os resultados automaticamente
        /// Também calcula o Tempo de Concentração automaticamente
        /// </summary>
        [AllowAnonymous]
        [Produces("application/json")]
        [HttpPost("/API/CalcularCaracterizacaoAutomatica")]
        public async Task<IActionResult> CalcularCaracterizacaoAutomatica([FromBody] CalcularCaracterizacaoRequest request)
        {
            try
            {
                // Buscar índice existente para a barragem
                var indices = await _IAplicacaoIndiceCaracterizacaoBH.ListarIndiceCaracterizacaoBH();
                var indiceExistente = indices.FirstOrDefault(x => x.Barragem_ID == request.BarragemId);

                if (indiceExistente == null)
                {
                    return NotFound(new { message = "Índice de caracterização não encontrado para esta barragem. Certifique-se de que os dados foram sincronizados primeiro." });
                }

                // Calcular todos os índices usando o método privado
                await CalcularIndicesAutomaticamente(indiceExistente);

                // Buscar novamente para retornar valores atualizados
                indiceExistente = await _IAplicacaoIndiceCaracterizacaoBH.BuscarPorId(indiceExistente.Id);

                // Calcular Tempo de Concentração automaticamente também
                await CalcularTempoConcentracaoAutomaticamente(request.BarragemId);

                return Ok(new
                {
                    success = true,
                    message = "Cálculos executados com sucesso",
                    barragemId = request.BarragemId,
                    resultados = new
                    {
                        indiceCircularidade = indiceExistente.ResultadoIndiceCircularidade,
                        fatorForma = indiceExistente.ResultadoFatorForma,
                        coeficienteCompacidade = indiceExistente.ResultadoCoeficienteCompacidade,
                        densidadeDrenagem = indiceExistente.ResultadoDensidadeDrenagem,
                        coeficienteManutencao = indiceExistente.ResultadoCoeficienteManutencao,
                        gradienteCanais = indiceExistente.ResultadoGradienteCanais,
                        relacaoRelevo = indiceExistente.ResultadoRelacaoRelevo,
                        indiceRugosidade = indiceExistente.ResultadoIndiceRugosidade,
                        sinuosidadeCursoDagua = indiceExistente.ResultadoSinuosidadeCursoDagua
                    }
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = ex.Message });
            }
        }

        /// <summary>
        /// Método privado para calcular Tempo de Concentração automaticamente
        /// </summary>
        private async Task CalcularTempoConcentracaoAutomaticamente(int barragemId)
        {
            try
            {
                var tempos = await _IAplicacaoTempoConcentracao.ListarTempoConcentracao();
                var tempoExistente = tempos.FirstOrDefault(x => x.BarragemId == barragemId);

                if (tempoExistente != null && tempoExistente.ComprimentoRioPrincipal_L > 0 && tempoExistente.DeclividadeBacia_S > 0)
                {
                    // Kirpich (1940)
                    tempoExistente.ResultadoKirpich = 0.0663 * Math.Pow(tempoExistente.ComprimentoRioPrincipal_L, 0.77) * Math.Pow(tempoExistente.DeclividadeBacia_S, -0.385);

                    // Corps Engineers (1946)
                    tempoExistente.ResultadoCorpsEngineers = 0.191 * Math.Pow(tempoExistente.ComprimentoRioPrincipal_L, 0.76) * Math.Pow(tempoExistente.DeclividadeBacia_S, -0.19);

                    // Carter (1961)
                    tempoExistente.ResultadoCarter = 0.0977 * Math.Pow(tempoExistente.ComprimentoRioPrincipal_L, 0.6) * Math.Pow(tempoExistente.DeclividadeBacia_S, -0.3);

                    // Dooge (1956)
                    if (tempoExistente.AreaDrenagem_A > 0)
                    {
                        tempoExistente.ResultadoDooge = 0.365 * Math.Pow(tempoExistente.AreaDrenagem_A, 0.41) * Math.Pow(tempoExistente.DeclividadeBacia_S, -0.17);
                    }

                    // Ven te Chow (1962)
                    var L = double.Parse(tempoExistente.ComprimentoRioPrincipal_L.ToString().Replace(",", "."));
                    var S = double.Parse(tempoExistente.DeclividadeBacia_S.ToString().Replace(",", "."));
                    tempoExistente.ResultadoVenTeChow = 0.160 * Math.Pow(L, 0.64) * Math.Pow(S, -0.32);

                    // Atualizar data de alteração
                    tempoExistente.DataAlteracao = DateTime.Now;

                    // Salvar novamente com os resultados calculados
                    await _IAplicacaoTempoConcentracao.Atualizar(tempoExistente);
                }
            }
            catch (Exception ex)
            {
                // Log erro mas não quebra o fluxo
                Console.WriteLine($"[CalcularTempoConcentracaoAutomaticamente] Erro: {ex.Message}");
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

    public class CalcularCaracterizacaoRequest
    {
        public int BarragemId { get; set; }
    }
}
