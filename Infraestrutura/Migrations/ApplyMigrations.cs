using Infraestrutura.Configuracoes;
using Microsoft.EntityFrameworkCore;
using Entidades.Entidades;
using System;
using System.Linq;

namespace Infraestrutura.Migrations
{
    public class ApplyMigrations
    {
        public static void Main(string[] args)
        {
            var optionsBuilder = new DbContextOptionsBuilder<Contexto>();
            optionsBuilder.UseSqlServer("Data Source=108.181.193.92,15000;Initial Catalog=sgsb;Persist Security Info=True;User ID=sa;Password=SenhaNova@123;TrustServerCertificate=true;MultipleActiveResultSets=True;Application Name=EntityFramework");
            
            using (var context = new Contexto(optionsBuilder.Options))
            {
                try
                {
                    Console.WriteLine("Aplicando migrations...");
                    context.Database.Migrate();
                    Console.WriteLine("Migrations aplicadas com sucesso!");
                    
                    // Inserir dados iniciais
                    SeedData(context);
                    
                    Console.WriteLine("Dados iniciais inseridos com sucesso!");
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Erro: {ex.Message}");
                    Console.WriteLine($"Stack: {ex.StackTrace}");
                }
            }
        }
        
        private static void SeedData(Contexto context)
        {
            // TipoMaterialBarragem
            if (!context.TipoMaterialBarragem.Any())
            {
                context.TipoMaterialBarragem.AddRange(
                    new TipoMaterialBarragem { Nome = "Concreto", DataCadastro = DateTime.Now, DataAlteracao = DateTime.Now },
                    new TipoMaterialBarragem { Nome = "Terra/Enrocamento", DataCadastro = DateTime.Now, DataAlteracao = DateTime.Now },
                    new TipoMaterialBarragem { Nome = "Mista", DataCadastro = DateTime.Now, DataAlteracao = DateTime.Now }
                );
            }
            
            // TipoEstruturaBarragem
            if (!context.TipoEstruturaBarragem.Any())
            {
                context.TipoEstruturaBarragem.AddRange(
                    new TipoEstruturaBarragem { Nome = "Gravidade", DataCadastro = DateTime.Now, DataAlteracao = DateTime.Now },
                    new TipoEstruturaBarragem { Nome = "Contenção", DataCadastro = DateTime.Now, DataAlteracao = DateTime.Now },
                    new TipoEstruturaBarragem { Nome = "Enrocamento", DataCadastro = DateTime.Now, DataAlteracao = DateTime.Now },
                    new TipoEstruturaBarragem { Nome = "Terra", DataCadastro = DateTime.Now, DataAlteracao = DateTime.Now }
                );
            }
            
            // CondicaoFundacao
            if (!context.CondicaoFundacao.Any())
            {
                context.CondicaoFundacao.AddRange(
                    new CondicaoFundacao { Nome = "Rocha Sã", DataCadastro = DateTime.Now, DataAlteracao = DateTime.Now },
                    new CondicaoFundacao { Nome = "Rocha Alterada", DataCadastro = DateTime.Now, DataAlteracao = DateTime.Now },
                    new CondicaoFundacao { Nome = "Solo Residual", DataCadastro = DateTime.Now, DataAlteracao = DateTime.Now },
                    new CondicaoFundacao { Nome = "Solo Transportado", DataCadastro = DateTime.Now, DataAlteracao = DateTime.Now }
                );
            }
            
            context.SaveChanges();
            
            // Criar uma barragem de exemplo
            if (!context.Barragem.Any())
            {
                var tipoMaterial = context.TipoMaterialBarragem.First();
                var tipoEstrutura = context.TipoEstruturaBarragem.First();
                var condicaoFundacao = context.CondicaoFundacao.First();
                
                var barragem = new Barragem
                {
                    Nome = "Barragem Exemplo",
                    Latitude = "-14.91049614092632",
                    Longitude = "-40.57034143018902",
                    BaciaHidrograficaAbrangencia = "Bacia do Rio São Francisco",
                    CursoDaguaBarrado = "Rio Exemplo",
                    AnoConclusaoObra = "2020",
                    IdadeBarragem = "4",
                    TipoFundacao = "Rocha Sã",
                    AlturaMAxima = 50.0,
                    ComprimentoCoroamento = 200.0,
                    LarguraCoroamentoBarragem = 10.0,
                    CotaCoroamentoBarragem = 500.0,
                    Tipo_Material_Id = tipoMaterial.Id,
                    Tipo_Estrutura_Id = tipoEstrutura.Id,
                    CondicaoFundacaoId = condicaoFundacao.Id,
                    DataCadastro = DateTime.Now,
                    DataAlteracao = DateTime.Now
                };
                
                context.Barragem.Add(barragem);
                context.SaveChanges();
            }
        }
    }
}

