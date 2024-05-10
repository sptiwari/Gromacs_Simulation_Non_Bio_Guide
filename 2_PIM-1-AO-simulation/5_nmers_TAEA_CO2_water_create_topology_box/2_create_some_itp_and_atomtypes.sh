cd topo

# Extract charges, bond, angle, and dihedral parameters of MOL molecule from MOL_GMX.top file
awk '/\[ system \]/ {exit} {print}' MOL_GMX.top | awk '/\[ moleculetype \]/,0' > MOL_GMX.itp

# Extract the atomtypes of MOL from MOL_GMX.top file
awk '/\[ moleculetype \]/ {exit} {print}' MOL_GMX.top > atomtypes.itp

# Add the following atomstypes to atomtypes.itp for atoms of other molecules in the system.
echo ';SPC/E atomtypes
 OW_spc   8           15.99940  -0.8476  A     0.3165492      0.650299455
 HW_spc   1           1.00800   0.4238   A     0              0
 Ow      8           15.99940    -0.8476     A       0.3165492   0.650299455
 Hw      1           1.00800     0.4238      A       0       0
;CO2 from Wei Shi paper (A version of TraPPE)
;Wei2008 https://pubs.acs.org/doi/10.1021/jp077223x double checked
 CCO2     6           12.0107   0.70     A     0.28000002359  0.22449252
 OCO2     8           15.99940  -0.350   A     0.30499997796  0.656841976
;N parameters for N2:
;N        7           14.0      0        A     0.331          0.299
;Trappe N2 verified
 N_n2     7           14.0      0        A     0.331          0.299214
 N_mid    0            0.0      0        V     0.000          0.000
;More atomtypes
 n3       n3          0.00000  0.00000   A     3.25000e-01   7.11280e-01 ; 1.82  0.1700
 n4       n4          0.00000  0.00000   A     3.25000e-01   7.11280e-01 ; 1.82  0.1700
 hx       hx          0.00000  0.00000   A     1.95998e-01   6.56888e-02 ; 1.10  0.0157


;[ nonbond_params ]
; i     j   func    sigma(c6)   eps(c12) ;Optionally add cross nonbond_params, if needed.
' >> atomtypes.itp

echo "Created MOL_GMX.itp and atomtypes.itp"

cp -v ../topol.top .
