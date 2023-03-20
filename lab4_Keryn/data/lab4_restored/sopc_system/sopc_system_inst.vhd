	component sopc_system is
		port (
			clk_clk            : in    std_logic                     := 'X';             -- clk
			reset_reset_n      : in    std_logic                     := 'X';             -- reset_n
			sdram_dq_export    : out   std_logic_vector(12 downto 0);                    -- export
			sdram_addr_export  : out   std_logic_vector(1 downto 0);                     -- export
			sdram_cs_n_export  : out   std_logic;                                        -- export
			sdram_we_n_export  : out   std_logic;                                        -- export
			sdram_ba_export    : out   std_logic;                                        -- export
			sdram_ras_n_export : inout std_logic_vector(15 downto 0) := (others => 'X'); -- export
			sdram_cas_n_export : out   std_logic;                                        -- export
			sdram_udqm_export  : out   std_logic;                                        -- export
			sdram_ldaqm_export : out   std_logic;                                        -- export
			sdram_cke_export   : out   std_logic;                                        -- export
			sdram_clk_clk      : out   std_logic                                         -- clk
		);
	end component sopc_system;

	u0 : component sopc_system
		port map (
			clk_clk            => CONNECTED_TO_clk_clk,            --         clk.clk
			reset_reset_n      => CONNECTED_TO_reset_reset_n,      --       reset.reset_n
			sdram_dq_export    => CONNECTED_TO_sdram_dq_export,    --    sdram_dq.export
			sdram_addr_export  => CONNECTED_TO_sdram_addr_export,  --  sdram_addr.export
			sdram_cs_n_export  => CONNECTED_TO_sdram_cs_n_export,  --  sdram_cs_n.export
			sdram_we_n_export  => CONNECTED_TO_sdram_we_n_export,  --  sdram_we_n.export
			sdram_ba_export    => CONNECTED_TO_sdram_ba_export,    --    sdram_ba.export
			sdram_ras_n_export => CONNECTED_TO_sdram_ras_n_export, -- sdram_ras_n.export
			sdram_cas_n_export => CONNECTED_TO_sdram_cas_n_export, -- sdram_cas_n.export
			sdram_udqm_export  => CONNECTED_TO_sdram_udqm_export,  --  sdram_udqm.export
			sdram_ldaqm_export => CONNECTED_TO_sdram_ldaqm_export, -- sdram_ldaqm.export
			sdram_cke_export   => CONNECTED_TO_sdram_cke_export,   --   sdram_cke.export
			sdram_clk_clk      => CONNECTED_TO_sdram_clk_clk       --   sdram_clk.clk
		);

