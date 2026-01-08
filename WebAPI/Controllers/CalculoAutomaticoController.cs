using Aplicacao.Interfaces;
using Entidades.Entidades;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Net.Http;
using System.Text.Json;

namespace WebAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CalculoAutomaticoController : ControllerBase
    {
        private readonly IAplicacaoTempoConcentracao _aplicacaoTempoConcentracao;
        private readonly IAplicacaoIndiceCaracterizacaoBH _aplicacaoIndiceCaracterizacaoBH;
        private readonly IAplicacaoVazaPico _aplicacaoVazaPico;
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly IConfiguration _configuration;

        public CalculoAutomaticoController(
            IAplicacaoTempoConcentracao aplicacaoTempoConcentracao,
            IAplicacaoIndiceCaracterizacaoBH aplicacaoIndiceCaracterizacaoBH,
            IAplicacaoVazaPico aplicacaoVazaPico,
            IHttpClientFactory httpClientFactory,
            IConfiguration configuration)
        {
            _aplicacaoTempoConcentracao = aplicacaoTempoConcentracao;
            _aplicacaoIndiceCaracterizacaoBH = aplicacaoIndiceCaracterizacaoBH;
            _aplicacaoVazaPico = aplicacaoVazaPico;
            _httpClientFactory = httpClientFactory;
            _configuration = configuration;
        }

        /// <summary>
        /// Busca dados de caracterização do SGSB_INSP e retorna todos os cálculos consolidados
        /// </summary>
        [AllowAnonymous]
        [Produces("application/json")]
        [HttpGet("/API/BuscarCalculosAutomaticosPorBarragem")]
        public async Task<IActionResult> BuscarCalculosAutomaticosPorBarragem(int barragemId)
        {
            try
            {
                // Buscar dados de caracterização do SGSB_INSP
                var caracterizacao = await BuscarCaracterizacaoDoSGSB_INSP(barragemId);

                // Buscar ou criar Tempo de Concentração
                var tempoConcentracao = await BuscarOuCriarTempoConcentracao(barragemId, caracterizacao);

                // Buscar ou criar Índice de Caracterização
                var indiceCaracterizacao = await BuscarOuCriarIndiceCaracterizacao(barragemId, caracterizacao);

                // Buscar ou criar Vazão de Pico
                var vazaoPico = await BuscarOuCriarVazaoPico(barragemId, caracterizacao);

                // Calcular todos os resultados
                await CalcularTempoConcentracao(barragemId);
                await CalcularIndiceCaracterizacao(barragemId);
                await CalcularVazaoPico(barragemId);

                // Buscar dados atualizados
                var tempos = await _aplicacaoTempoConcentracao.ListarTempoConcentracao();
                var indices = await _aplicacaoIndiceCaracterizacaoBH.ListarIndiceCaracterizacaoBH();
                var vazoes = await _aplicacaoVazaPico.ListarVazaPico();

                var tempoAtualizado = tempos.FirstOrDefault(x => x.BarragemId == barragemId);
                var indiceAtualizado = indices.FirstOrDefault(x => x.Barragem_ID == barragemId);
                var vazaoAtualizada = vazoes.FirstOrDefault(x => x.BarragemId == barragemId);

                return Ok(new
                {
                    success = true,
                    barragemId = barragemId,
                    tempoConcentracao = tempoAtualizado != null ? new
                    {
                        id = tempoAtualizado.Id,
                        dadosEntrada = new
                        {
                            comprimentoRioPrincipal_L = tempoAtualizado.ComprimentoRioPrincipal_L,
                            declividadeBacia_S = tempoAtualizado.DeclividadeBacia_S,
                            areaDrenagem_A = tempoAtualizado.AreaDrenagem_A
                        },
                        resultados = new
                        {
                            kirpich = tempoAtualizado.ResultadoKirpich,
                            corpsEngineers = tempoAtualizado.ResultadoCorpsEngineers,
                            carter = tempoAtualizado.ResultadoCarter,
                            dooge = tempoAtualizado.ResultadoDooge,
                            venTeChow = tempoAtualizado.ResultadoVenTeChow
                        },
                        grafico = new[]
                        {
                            new { metodo = "Kirpich", tempo = tempoAtualizado.ResultadoKirpich },
                            new { metodo = "Corps Engineers", tempo = tempoAtualizado.ResultadoCorpsEngineers },
                            new { metodo = "Carter", tempo = tempoAtualizado.ResultadoCarter },
                            new { metodo = "Dooge", tempo = tempoAtualizado.ResultadoDooge },
                            new { metodo = "Ven te Chow", tempo = tempoAtualizado.ResultadoVenTeChow }
                        }
                    } : null,
                    indiceCaracterizacao = indiceAtualizado != null ? new
                    {
                        id = indiceAtualizado.Id,
                        dadosEntrada = new
                        {
                            areaBaciaHidrografica = indiceAtualizado.AreaBaciaHidrografica,
                            perimetro = indiceAtualizado.Perimetro,
                            comprimentoRioPrincipal = indiceAtualizado.ComprimentoRioPrincipal,
                            comprimentoVetorialRioPrincipal = indiceAtualizado.ComprimentoVetorialRioPrincipal,
                            comprimentoTotalRioBacia = indiceAtualizado.ComprimentoTotalRioBacia,
                            altitudeMaximaBacia = indiceAtualizado.AltitudeMaximaBacia,
                            altitudeMinimaBacia = indiceAtualizado.AltitudeMinimaBacia,
                            altitudeAltimetricaBaciaM = indiceAtualizado.AltitudeAltimetricaBaciaM,
                            comprimentoAxialBacia = indiceAtualizado.ComprimentoAxialBacia
                        },
                        resultados = new
                        {
                            indiceCircularidade = indiceAtualizado.ResultadoIndiceCircularidade,
                            fatorForma = indiceAtualizado.ResultadoFatorForma,
                            coeficienteCompacidade = indiceAtualizado.ResultadoCoeficienteCompacidade,
                            densidadeDrenagem = indiceAtualizado.ResultadoDensidadeDrenagem,
                            coeficienteManutencao = indiceAtualizado.ResultadoCoeficienteManutencao,
                            gradienteCanais = indiceAtualizado.ResultadoGradienteCanais,
                            relacaoRelevo = indiceAtualizado.ResultadoRelacaoRelevo,
                            indiceRugosidade = indiceAtualizado.ResultadoIndiceRugosidade,
                            sinuosidadeCursoDagua = indiceAtualizado.ResultadoSinuosidadeCursoDagua
                        },
                        grafico = new[]
                        {
                            new { nome = "Índice Circularidade", valor = indiceAtualizado.ResultadoIndiceCircularidade },
                            new { nome = "Fator Forma", valor = indiceAtualizado.ResultadoFatorForma },
                            new { nome = "Coef. Compacidade", valor = indiceAtualizado.ResultadoCoeficienteCompacidade },
                            new { nome = "Densidade Drenagem", valor = indiceAtualizado.ResultadoDensidadeDrenagem },
                            new { nome = "Coef. Manutenção", valor = indiceAtualizado.ResultadoCoeficienteManutencao },
                            new { nome = "Gradiente Canais", valor = indiceAtualizado.ResultadoGradienteCanais },
                            new { nome = "Relação Relevo", valor = indiceAtualizado.ResultadoRelacaoRelevo },
                            new { nome = "Índice Rugosidade", valor = indiceAtualizado.ResultadoIndiceRugosidade },
                            new { nome = "Sinuosidade", valor = indiceAtualizado.ResultadoSinuosidadeCursoDagua }
                        }
                    } : null,
                    vazaoPico = vazaoAtualizada != null ? CalcularVazaoPicoResultados(vazaoAtualizada) : null
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = ex.Message });
            }
        }

        private async Task<Dictionary<string, object?>> BuscarCaracterizacaoDoSGSB_INSP(int barragemId)
        {
            try
            {
                // URL do SGSB_INSP - ajustar conforme necessário
                var sgsbInspUrl = _configuration["SGSB_INSP:BaseUrl"] ?? "http://localhost:3000";
                var client = _httpClientFactory.CreateClient();
                client.Timeout = TimeSpan.FromSeconds(10);

                var response = await client.GetAsync($"{sgsbInspUrl}/api/trpc/caracterizacao.getCaracterizacaoByBarragem?input={{\"json\":{{\"barragemId\":{barragemId}}}}}");

                if (response.IsSuccessStatusCode)
                {
                    var content = await response.Content.ReadAsStringAsync();
                    var jsonDoc = JsonDocument.Parse(content);
                    return JsonSerializer.Deserialize<Dictionary<string, object?>>(content) ?? new Dictionary<string, object?>();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"[CalculoAutomatico] Erro ao buscar caracterização do SGSB_INSP: {ex.Message}");
            }

            return new Dictionary<string, object?>();
        }

        private async Task<TempoConcentracao?> BuscarOuCriarTempoConcentracao(int barragemId, Dictionary<string, object?> caracterizacao)
        {
            var tempos = await _aplicacaoTempoConcentracao.ListarTempoConcentracao();
            var tempoExistente = tempos.FirstOrDefault(x => x.BarragemId == barragemId);

            if (tempoExistente == null && caracterizacao.Count > 0)
            {
                // Criar novo registro com dados da caracterização
                var novo = new TempoConcentracao
                {
                    BarragemId = barragemId,
                    ComprimentoRioPrincipal_L = (double)(GetDecimalValue(caracterizacao, "comprimentoRioPrincipal_L") ?? GetDecimalValue(caracterizacao, "comprimentoRioPrincipal") ?? 0),
                    DeclividadeBacia_S = (double)(GetDecimalValue(caracterizacao, "declividadeBacia_S") ?? 0),
                    AreaDrenagem_A = (double)(GetDecimalValue(caracterizacao, "areaDrenagem_A") ?? GetDecimalValue(caracterizacao, "areaBaciaHidrografica") ?? 0),
                    DataCadastro = DateTime.Now
                };

                await _aplicacaoTempoConcentracao.Adicionar(novo);
                return novo;
            }

            return tempoExistente;
        }

        private async Task<IndiceCaracterizacaoBH?> BuscarOuCriarIndiceCaracterizacao(int barragemId, Dictionary<string, object?> caracterizacao)
        {
            var indices = await _aplicacaoIndiceCaracterizacaoBH.ListarIndiceCaracterizacaoBH();
            var indiceExistente = indices.FirstOrDefault(x => x.Barragem_ID == barragemId);

            if (indiceExistente == null && caracterizacao.Count > 0)
            {
                // Criar novo registro com dados da caracterização
                var novo = new IndiceCaracterizacaoBH
                {
                    Barragem_ID = barragemId,
                    AreaBaciaHidrografica = (double)(GetDecimalValue(caracterizacao, "areaBaciaHidrografica") ?? 0),
                    Perimetro = (double)(GetDecimalValue(caracterizacao, "perimetro") ?? 0),
                    ComprimentoRioPrincipal = (double)(GetDecimalValue(caracterizacao, "comprimentoRioPrincipal") ?? 0),
                    ComprimentoVetorialRioPrincipal = (double)(GetDecimalValue(caracterizacao, "comprimentoVetorialRioPrincipal") ?? 0),
                    ComprimentoTotalRioBacia = (double)(GetDecimalValue(caracterizacao, "comprimentoTotalRioBacia") ?? 0),
                    AltitudeMaximaBacia = (double)(GetDecimalValue(caracterizacao, "altitudeMaximaBacia") ?? 0),
                    AltitudeMinimaBacia = (double)(GetDecimalValue(caracterizacao, "altitudeMinimaBacia") ?? 0),
                    AltitudeAltimetricaBaciaM = (double)(GetDecimalValue(caracterizacao, "altitudeAltimetricaBaciaM") ?? 0),
                    ComprimentoAxialBacia = (double)(GetDecimalValue(caracterizacao, "comprimentoAxialBacia") ?? 0),
                    DataCadastro = DateTime.Now
                };

                await _aplicacaoIndiceCaracterizacaoBH.Adicionar(novo);
                return novo;
            }

            return indiceExistente;
        }

        private async Task<VazaPico?> BuscarOuCriarVazaoPico(int barragemId, Dictionary<string, object?> caracterizacao)
        {
            var vazoes = await _aplicacaoVazaPico.ListarVazaPico();
            var vazaoExistente = vazoes.FirstOrDefault(x => x.BarragemId == barragemId);

            if (vazaoExistente == null && caracterizacao.Count > 0)
            {
                // Criar novo registro com dados da caracterização
                var novo = new VazaPico
                {
                    BarragemId = barragemId,
                    valorVhid = (double?)((decimal)(GetDecimalValue(caracterizacao, "volumeReservatorio") ?? 0)),
                    valorHhid = (double?)((decimal)(GetDecimalValue(caracterizacao, "cargaHidraulicaMaxima") ?? 0)),
                    valorYmed = (double?)((decimal)(GetDecimalValue(caracterizacao, "profundidadeMediaReservatorio") ?? 0)),
                    valorAS = (double?)((decimal)(GetDecimalValue(caracterizacao, "areaReservatorio") ?? 0)),
                    DataCadastro = DateTime.Now
                };

                await _aplicacaoVazaPico.Adicionar(novo);
                return novo;
            }

            return vazaoExistente;
        }

        private async Task CalcularTempoConcentracao(int barragemId)
        {
            var tempos = await _aplicacaoTempoConcentracao.ListarTempoConcentracao();
            var tempoExistente = tempos.FirstOrDefault(x => x.BarragemId == barragemId);

            if (tempoExistente != null && tempoExistente.ComprimentoRioPrincipal_L > 0 && tempoExistente.DeclividadeBacia_S > 0)
            {
                tempoExistente.ResultadoKirpich = 0.0663 * Math.Pow(tempoExistente.ComprimentoRioPrincipal_L, 0.77) * Math.Pow(tempoExistente.DeclividadeBacia_S, -0.385);
                tempoExistente.ResultadoCorpsEngineers = 0.191 * Math.Pow(tempoExistente.ComprimentoRioPrincipal_L, 0.76) * Math.Pow(tempoExistente.DeclividadeBacia_S, -0.19);
                tempoExistente.ResultadoCarter = 0.0977 * Math.Pow(tempoExistente.ComprimentoRioPrincipal_L, 0.6) * Math.Pow(tempoExistente.DeclividadeBacia_S, -0.3);
                
                if (tempoExistente.AreaDrenagem_A > 0)
                {
                    tempoExistente.ResultadoDooge = 0.365 * Math.Pow(tempoExistente.AreaDrenagem_A, 0.41) * Math.Pow(tempoExistente.DeclividadeBacia_S, -0.17);
                }

                var L = double.Parse(tempoExistente.ComprimentoRioPrincipal_L.ToString().Replace(",", "."));
                var S = double.Parse(tempoExistente.DeclividadeBacia_S.ToString().Replace(",", "."));
                tempoExistente.ResultadoVenTeChow = 0.160 * Math.Pow(L, 0.64) * Math.Pow(S, -0.32);

                tempoExistente.DataAlteracao = DateTime.Now;
                await _aplicacaoTempoConcentracao.Atualizar(tempoExistente);
            }
        }

        private async Task CalcularIndiceCaracterizacao(int barragemId)
        {
            var indices = await _aplicacaoIndiceCaracterizacaoBH.ListarIndiceCaracterizacaoBH();
            var indiceExistente = indices.FirstOrDefault(x => x.Barragem_ID == barragemId);

            if (indiceExistente != null && indiceExistente.Perimetro > 0 && indiceExistente.AreaBaciaHidrografica > 0)
            {
                indiceExistente.ResultadoIndiceCircularidade = 12.57 * (indiceExistente.AreaBaciaHidrografica / Math.Pow(indiceExistente.Perimetro, 2));

                if (indiceExistente.ComprimentoAxialBacia > 0)
                {
                    indiceExistente.ResultadoFatorForma = indiceExistente.Perimetro / Math.Pow(indiceExistente.ComprimentoAxialBacia, 2);
                }

                indiceExistente.ResultadoCoeficienteCompacidade = 0.28 * (indiceExistente.Perimetro / Math.Sqrt(indiceExistente.AreaBaciaHidrografica));

                if (indiceExistente.AreaBaciaHidrografica > 0)
                {
                    indiceExistente.ResultadoDensidadeDrenagem = indiceExistente.ComprimentoTotalRioBacia / indiceExistente.AreaBaciaHidrografica;

                    if (indiceExistente.ResultadoDensidadeDrenagem > 0)
                    {
                        indiceExistente.ResultadoCoeficienteManutencao = 1 / indiceExistente.ResultadoDensidadeDrenagem;
                    }
                }

                if (indiceExistente.ComprimentoRioPrincipal > 0)
                {
                    indiceExistente.ResultadoGradienteCanais = (indiceExistente.AltitudeAltimetricaBaciaM / (indiceExistente.ComprimentoRioPrincipal * 1000)) * 100;
                    indiceExistente.ResultadoRelacaoRelevo = indiceExistente.AltitudeAltimetricaBaciaM / indiceExistente.ComprimentoRioPrincipal;
                }

                indiceExistente.ResultadoIndiceRugosidade = indiceExistente.AltitudeAltimetricaBaciaM / 1000;

                if (indiceExistente.ComprimentoVetorialRioPrincipal > 0 && indiceExistente.ComprimentoRioPrincipal > 0)
                {
                    indiceExistente.ResultadoSinuosidadeCursoDagua = indiceExistente.ComprimentoRioPrincipal / indiceExistente.ComprimentoVetorialRioPrincipal;
                }

                indiceExistente.DataAlteracao = DateTime.Now;
                await _aplicacaoIndiceCaracterizacaoBH.Atualizar(indiceExistente);
            }
        }

        private async Task CalcularVazaoPico(int barragemId)
        {
            var vazoes = await _aplicacaoVazaPico.ListarVazaPico();
            var vazaoExistente = vazoes.FirstOrDefault(x => x.BarragemId == barragemId);

            if (vazaoExistente != null && vazaoExistente.valorHhid.HasValue && vazaoExistente.valorHhid.Value > 0)
            {
                vazaoExistente.DataAlteracao = DateTime.Now;
                await _aplicacaoVazaPico.Atualizar(vazaoExistente);
            }
        }

        private object? CalcularVazaoPicoResultados(VazaPico vazao)
        {
            if (vazao == null || !vazao.valorHhid.HasValue || vazao.valorHhid.Value <= 0)
                return null;

            var Hhid = (double)vazao.valorHhid;
            var Vhid = vazao.valorVhid ?? 0;
            var Ymed = vazao.valorYmed ?? 0;
            var LarguraBarragem = 0.0; // Propriedade não existe na entidade VazaPico
            var Hbarr = 0.0; // Propriedade não existe na entidade VazaPico
            var AS = vazao.valorAS ?? 0;

            // Calcular todos os métodos de vazão de pico
            var lou = 7.683 * Math.Pow(Hhid, 1.909);
            var saintVenant = Ymed > 0 && LarguraBarragem > 0 
                ? 0.296 * LarguraBarragem * Math.Sqrt(9.8 * Math.Pow(Ymed, 1.5)) 
                : 0;
            var usbr1982 = 19 * Math.Pow(Hhid, 1.85);
            var soilConservationService = 16.6 * Math.Pow(Hhid, 1.85);
            var kirkpatrick = 1.268 * Math.Pow(Hhid + 0.3, 2.5);
            var froehlich = Vhid > 0 
                ? 0.607 * 0.934 * Math.Pow(Vhid, 0.295) * Math.Pow(Hhid, 1.24) 
                : 0;
            var institutionCivilEngineers = 1.3 * Math.Pow(Hhid, 2.5);
            var evans = Vhid > 0 ? 0.72 * Math.Pow(Vhid, 0.53) : 0;
            var costa = Vhid > 0 && Hhid > 0 
                ? 0.763 * Math.Pow(Vhid * Hhid, 0.42) 
                : 0;
            var webby = Vhid > 0 && Hhid > 0 
                ? 0.0443 * Math.Sqrt(9.8) * Math.Pow(Hhid, 1.4) * Math.Pow(Vhid, 0.367) 
                : 0;
            var usbr1989 = Hbarr > 0 && Vhid > 0 
                ? 6.14 * Math.Pow(Hbarr, 1.81) * Math.Pow(Vhid, 0.061) 
                : 0;
            var lemperiere = Vhid > 0 && Hhid > 0 
                ? Math.Pow(Hhid, 0.5) * (Math.Pow(Hhid, 2) + 0.1 * Math.Pow(Vhid, 0.5)) 
                : 0;
            var espanhaMinisterioMedioAmbiente = Hbarr > 0 && Vhid > 0 
                ? 0.78 * Math.Sqrt(Hbarr * Vhid) 
                : 0;
            var singhSnorrason = Hbarr > 0 
                ? 13.4 * Math.Pow(Hbarr, 1.89) 
                : 0;

            var grafico = new[]
            {
                new { metodo = "Lou", vazao = lou },
                new { metodo = "Saint-Venant", vazao = saintVenant },
                new { metodo = "USBR 1982", vazao = usbr1982 },
                new { metodo = "Soil Conservation", vazao = soilConservationService },
                new { metodo = "Kirkpatrick", vazao = kirkpatrick },
                new { metodo = "Froehlich", vazao = froehlich },
                new { metodo = "Institution Civil Engineers", vazao = institutionCivilEngineers },
                new { metodo = "Evans", vazao = evans },
                new { metodo = "Costa", vazao = costa },
                new { metodo = "Webby", vazao = webby },
                new { metodo = "USBR 1989", vazao = usbr1989 },
                new { metodo = "Lemperière", vazao = lemperiere },
                new { metodo = "Espanha - Ministerio", vazao = espanhaMinisterioMedioAmbiente },
                new { metodo = "Singh e Snorrason", vazao = singhSnorrason }
            };

            return new
            {
                id = vazao.Id,
                dadosEntrada = new
                {
                    valorVhid = vazao.valorVhid,
                    valorHhid = vazao.valorHhid,
                    valorYmed = vazao.valorYmed,
                    valorAS = vazao.valorAS,
                    valorLarguraBarragem = (double?)null, // Propriedade não existe na entidade
                    valorHbarr = (double?)null // Propriedade não existe na entidade
                },
                resultados = new
                {
                    lou,
                    saintVenant,
                    usbr1982,
                    soilConservationService,
                    kirkpatrick,
                    froehlich,
                    institutionCivilEngineers,
                    evans,
                    costa,
                    webby,
                    usbr1989,
                    lemperiere,
                    espanhaMinisterioMedioAmbiente,
                    singhSnorrason
                },
                grafico
            };
        }

        private decimal? GetDecimalValue(Dictionary<string, object?> dict, string key)
        {
            if (dict.TryGetValue(key, out var value) && value != null)
            {
                if (value is JsonElement jsonElement)
                {
                    if (jsonElement.ValueKind == JsonValueKind.Number)
                    {
                        return jsonElement.GetDecimal();
                    }
                    if (jsonElement.ValueKind == JsonValueKind.String && decimal.TryParse(jsonElement.GetString(), out var parsed))
                    {
                        return parsed;
                    }
                }
                else if (decimal.TryParse(value.ToString(), out var parsed))
                {
                    return parsed;
                }
            }
            return null;
        }
    }
}

